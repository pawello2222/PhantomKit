//
//  Binding+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import SwiftUI

extension Binding {
    /// Creates a binding with an immutable value.
    ///
    /// Use this method to create a binding to a value that cannot change.
    /// This can be useful when using a ``PreviewProvider`` to see how a view
    /// represents different values.
    ///
    /// - Parameter value: An immutable value.
    public static func c(_ value: Value) -> Self {
        constant(value)
    }
}

// MARK: - Operators

/// Created a binding by unwrapping a given value and providing a default value.
public func ?? <T>(lhs: Binding<T?>, rhs: T) -> Binding<T> {
    .init(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
