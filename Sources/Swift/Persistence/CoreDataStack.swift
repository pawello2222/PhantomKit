//
//  CoreDataStack.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11.06.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import CoreData
import os.log

open class CoreDataStack {
    private let modelName: String
    private var useCloudSync: Bool
    private var container: NSPersistentContainer

    public init(modelName: String, useCloudSync: Bool = false) {
        self.modelName = modelName
        self.useCloudSync = useCloudSync
        container = Self.initContainer(name: modelName, useCloudSync: useCloudSync)
    }
}

// MARK: - PersistentStore

extension CoreDataStack: PersistentStore {
    public func fetch<T, V>(_ request: NSFetchRequest<T>, map: @escaping (T) -> V?) -> [V] where T: ManagedEntity {
        do {
            return try mainContext.fetch(request).compactMap(map)
        } catch {
            Logger.error(error.nsErrorDescription, category: .coreData)
            return []
        }
    }

    public func delete(_ request: NSBatchDeleteRequest) {
        do {
            try mainContext.execute(request)
        } catch {
            Logger.error(error.nsErrorDescription, category: .coreData)
        }
    }

    public func save(_ operation: @escaping DBOperation<Void>) {
        let context = workingContext
        do {
            try operation(context)
        } catch {
            Logger.error(error.nsErrorDescription, category: .coreData)
        }
        saveWorkingContext(context: context)
    }

    public func reloadContainer(useCloudSync: Bool) {
        guard self.useCloudSync != useCloudSync else { return }
        self.useCloudSync = useCloudSync
        container = Self.initContainer(name: modelName, useCloudSync: useCloudSync)
    }
}

// MARK: - Container

extension CoreDataStack {
    private static func initContainer(name: String, useCloudSync: Bool) -> NSPersistentContainer {
        let container = useCloudSync
            ? initCloudContainer(name: name)
            : initLocalContainer(name: name)
        container.loadPersistentStores { storeDescription, error in
            container.viewContext.automaticallyMergesChangesFromParent = true
            if let error = error {
                Logger.error(error.nsErrorDescription, category: .coreData)
            } else {
                Logger.debug("Init: \(storeDescription)", category: .coreData)
            }
        }
        return container
    }

    private static func initCloudContainer(name: String) -> NSPersistentContainer {
        let container = NSPersistentCloudKitContainer(name: name)
        let description = container.persistentStoreDescriptions.first
        description?.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        return container
    }

    private static func initLocalContainer(name: String) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: name)
        let description = container.persistentStoreDescriptions.first
        description?.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        return container
    }
}

// MARK: - Context

extension CoreDataStack {
    private var mainContext: NSManagedObjectContext {
        container.viewContext
    }

    private var workingContext: NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = mainContext
        return context
    }

    private func saveMainContext() {
        mainContext.performAndWait {
            if mainContext.hasChanges {
                do {
                    try mainContext.save()
                } catch {
                    Logger.error(error.nsErrorDescription, category: .coreData)
                }
            }
        }
    }

    private func saveWorkingContext(context: NSManagedObjectContext) {
        do {
            try context.save()
            saveMainContext()
        } catch {
            Logger.error(error.nsErrorDescription, category: .coreData)
        }
    }
}

// MARK: - Log

extension OSLog {
    private static let subsystem = Bundle.phantomKit.identifier

    fileprivate static let coreData = OSLog(subsystem: subsystem, category: "CoreData")
}
