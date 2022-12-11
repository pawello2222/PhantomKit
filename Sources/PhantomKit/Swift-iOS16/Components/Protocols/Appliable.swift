//
//  Appliable.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import Foundation

// MARK: - Appliable

public protocol Appliable {}

extension Appliable {
    /// Applies the given transform to this object.
    ///
    /// ```swift
    /// let button = UIButton().apply {
    ///     $0.setTitle("Hello, world!", for: .normal)
    /// }
    /// ```
    ///
    /// - Parameter transform: The transform to apply.
    @discardableResult
    public func apply(_ transform: (Self) throws -> Void) rethrows -> Self {
        try transform(self)
        return self
    }
}

// MARK: - MutableAppliable

public protocol MutableAppliable {}

extension MutableAppliable {
    /// Applies the given transform to this object.
    ///
    /// - Parameter transform: The transform to apply.
    @discardableResult
    public func applying(_ transform: (inout Self) throws -> Void) rethrows -> Self {
        var object = self
        try transform(&object)
        return object
    }

    /// Applies the given transform to this object.
    ///
    /// - Parameter transform: The transform to apply.
    public mutating func apply(_ transform: (inout Self) throws -> Void) rethrows {
        var object = self
        try transform(&object)
        self = object
    }
}

// MARK: - Extensions

extension NSObject: Appliable {}
extension DependencyContainer: Appliable {}

extension URLRequest: MutableAppliable {}
