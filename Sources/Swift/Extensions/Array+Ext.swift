//
//  Array+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable, Element.ID: Comparable {
    public mutating func toggle(_ item: Element) {
        if let index = firstIndex(where: \.id, equals: item.id) {
            remove(at: index)
        } else {
            append(item)
        }
    }
}

extension Array {
    public func firstIndex<Value>(
        where keyPath: KeyPath<Element, Value>,
        equals value: Value
    ) -> Index? where Value: Comparable {
        firstIndex {
            $0[keyPath: keyPath] == value
        }
    }
}
