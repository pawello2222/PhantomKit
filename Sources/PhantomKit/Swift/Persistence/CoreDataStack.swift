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
    private let storeURL: URL?
    private var isCloud: Bool
    private var container: NSPersistentContainer

    public init(modelName: String, storeURL: URL? = nil, isCloud: Bool = false) {
        self.modelName = modelName
        self.storeURL = storeURL
        self.isCloud = isCloud
        container = Self.initContainer(name: modelName, storeURL: storeURL, isCloud: isCloud)
    }
}

// MARK: - PersistentStore

extension CoreDataStack: PersistentStore {
    public func fetch<T, V>(_ request: NSFetchRequest<T>, map: @escaping (T) -> V?) -> [V] where T: ManagedEntity {
        do {
            return try mainContext.fetch(request).compactMap(map)
        } catch {
            Logger.error(error.description, category: .coreData)
            return []
        }
    }

    public func delete(_ request: NSBatchDeleteRequest) {
        do {
            try mainContext.execute(request)
        } catch {
            Logger.error(error.description, category: .coreData)
        }
    }

    public func save(_ operation: @escaping DBOperation<Void>) {
        let context = workingContext
        do {
            try operation(context)
        } catch {
            Logger.error(error.description, category: .coreData)
        }
        saveWorkingContext(context: context)
    }

    public func reloadContainer(isCloud: Bool) {
        guard self.isCloud != isCloud else { return }
        self.isCloud = isCloud
        container = Self.initContainer(name: modelName, storeURL: storeURL, isCloud: isCloud)
    }
}

// MARK: - Container

extension CoreDataStack {
    private static func initContainer(name: String, storeURL: URL?, isCloud: Bool) -> NSPersistentContainer {
        let container = isCloud
            ? initCloudContainer(name: name, storeURL: storeURL)
            : initLocalContainer(name: name, storeURL: storeURL)
        container.loadPersistentStores { storeDescription, error in
            container.viewContext.automaticallyMergesChangesFromParent = true
            if let error = error {
                Logger.error(error.description, category: .coreData)
            } else {
                Logger.debug("Init: \(storeDescription)", category: .coreData)
            }
        }
        return container
    }

    private static func initCloudContainer(name: String, storeURL: URL?) -> NSPersistentContainer {
        let container = NSPersistentCloudKitContainer(name: name)
        let description = storeDescription(for: container, storeURL: storeURL)
        description?.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        return container
    }

    private static func initLocalContainer(name: String, storeURL: URL?) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: name)
        let description = storeDescription(for: container, storeURL: storeURL)
        description?.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        return container
    }

    private static func storeDescription(
        for container: NSPersistentContainer,
        storeURL: URL?
    ) -> NSPersistentStoreDescription? {
        guard let storeURL = storeURL else {
            return container.persistentStoreDescriptions.first
        }
        let description = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [description]
        return description
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
                    Logger.error(error.description, category: .coreData)
                }
            }
        }
    }

    private func saveWorkingContext(context: NSManagedObjectContext) {
        do {
            try context.save()
            saveMainContext()
        } catch {
            Logger.error(error.description, category: .coreData)
        }
    }
}

// MARK: - Log

extension OSLog {
    private static let subsystem = Bundle.phantomKit.identifier

    fileprivate static let coreData = OSLog(subsystem: subsystem, category: "CoreData")
}
