//
//  Array+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

// MARK: KeyPath

extension Array {
    public func firstIndex<Value>(
        where keyPath: KeyPath<Element, Value>,
        equals value: Value
    ) -> Index? where Value: Equatable {
        firstIndex {
            $0[keyPath: keyPath] == value
        }
    }
}

extension Array {
    public func first<Value>(
        where keyPath: KeyPath<Element, Value>,
        equals value: Value
    ) -> Element? where Value: Equatable {
        first {
            $0[keyPath: keyPath] == value
        }
    }
}

extension Array {
    public func filter<Value>(
        where keyPath: KeyPath<Element, Value>,
        equals value: Value
    ) -> Self where Value: Equatable {
        filter {
            $0[keyPath: keyPath] == value
        }
    }
}

extension Array {
    public mutating func removeFirst<Value>(
        where keyPath: KeyPath<Element, Value>,
        equals value: Value
    ) where Value: Equatable {
        if let index = firstIndex(where: keyPath, equals: value) {
            remove(at: index)
        }
    }
}

// MARK: Remove

extension Array where Element: Equatable {
    public mutating func removeFirst(_ item: Element) {
        if let index = firstIndex(where: { $0 == item }) {
            remove(at: index)
        }
    }
}

// MARK: Toggle

extension Array where Element: Identifiable {
    public mutating func toggle(_ item: Element) {
        if let index = firstIndex(where: \.id, equals: item.id) {
            remove(at: index)
        } else {
            append(item)
        }
    }
}

// MARK: - Subscript

extension Array where Element: Equatable {
    public subscript(safe bounds: Range<Int>) -> ArraySlice<Element> {
        let lower = bounds.lowerBound.clamped(to: 0...count)
        let upper = bounds.upperBound.clamped(to: 0...count)
        return self[lower..<upper]
    }
}
