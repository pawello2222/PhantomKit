//
//  PersistentStore.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11.06.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import CoreData

public protocol PersistentStore {
    typealias DBOperation<Result> = (NSManagedObjectContext) throws -> Result

    func fetch<T, V>(_ request: NSFetchRequest<T>, map: @escaping (T) -> V?) -> [V] where T: ManagedEntity
    func delete(_ request: NSBatchDeleteRequest)
    func save(_ operation: @escaping DBOperation<Void>)
    func reloadContainer(isCloud: Bool)
}
