//
//  ManagedEntity.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11.06.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import CoreData

public protocol ManagedEntity: NSFetchRequestResult {}

extension ManagedEntity where Self: NSManagedObject {
    public static var entityName: String {
        let nameMO = String(describing: Self.self)
        return nameMO.replacingOccurrences(of: "MO", with: "")
    }

    public static func insertNew(in context: NSManagedObjectContext) -> Self? {
        NSEntityDescription
            .insertNewObject(forEntityName: entityName, into: context) as? Self
    }

    public static func newFetchRequest(predicate: NSPredicate? = nil) -> NSFetchRequest<Self> {
        let fetchRequest = NSFetchRequest<Self>(entityName: entityName)
        fetchRequest.predicate = predicate
        return fetchRequest
    }

    public static func newBatchDeleteRequest(predicate: NSPredicate? = nil) -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = predicate
        return .init(fetchRequest: fetchRequest)
    }
}
