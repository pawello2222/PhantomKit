//
//  Array+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 02/07/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

import Foundation

// MARK: - Subscript

extension Array {
    /// Accesses the element at the specified position.
    /// Returns `nil` if the index is out of bounds.
    public subscript(safe index: Int) -> Element? {
        guard 0 ..< count ~= index else {
            return nil
        }
        return self[index]
    }
}

// MARK: Toggle

extension Array where Element: Equatable {
    /// Removes the element if it's present in the array
    /// or appends it otherwise.
    public mutating func toggle(_ element: Element) {
        if let index = firstIndex(where: { $0 == element }) {
            remove(at: index)
        } else {
            append(element)
        }
    }
}
