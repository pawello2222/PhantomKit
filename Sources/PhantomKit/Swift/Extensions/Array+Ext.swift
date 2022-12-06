//
//  Array+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation
import Xcore

// MARK: Iterator

extension Array {
    public func next(ofIndex index: Index, looped: Bool = false) -> Element? where Element: Equatable {
        guard indices.contains(index) else {
            return nil
        }
        ServiceLocator
        let nextIndex = self.index(after: index)
        guard nextIndex != endIndex else {
            return looped ? first : nil
        }
        return self[nextIndex]
    }

    public func next(of element: Element, looped: Bool = false) -> Element? where Element: Equatable {
        guard let currentIndex = firstIndex(where: \.self, equals: element) else {
            return nil
        }
        return next(ofIndex: currentIndex, looped: looped)
    }
}

// MARK: KeyPath

extension Array {
    public func contains<Value>(
        where keyPath: KeyPath<Element, Value>,
        equals value: Value
    ) -> Bool where Value: Equatable {
        contains {
            $0[keyPath: keyPath] == value
        }
    }
}

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

    public func filter<Value>(
        where keyPath: KeyPath<Element, Value>,
        notEquals value: Value
    ) -> Self where Value: Equatable {
        filter {
            $0[keyPath: keyPath] != value
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

// MARK: Toggle

extension Array where Element: Equatable {
    public mutating func toggle(_ element: Element) {
        if let index = firstIndex(where: \.self, equals: element) {
            remove(at: index)
        } else {
            append(element)
        }
    }
}

// MARK: - Subscript

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard 0 ..< count ~= index else {
            return nil
        }
        return self[index]
    }
}

extension Array where Element: Equatable {
    public subscript(safe bounds: Range<Int>) -> ArraySlice<Element> {
        let lower = bounds.lowerBound.clamped(to: 0 ... count)
        let upper = bounds.upperBound.clamped(to: 0 ... count)
        return self[lower ..< upper]
    }
}
