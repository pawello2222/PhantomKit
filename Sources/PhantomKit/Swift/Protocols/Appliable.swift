//
//  Appliable.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 19/06/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

import Foundation

public protocol Appliable {}

extension Appliable where Self: Any {
    public func applying(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }

    public func `do`(_ block: (Self) throws -> Void) rethrows {
        try block(self)
    }
}

extension Appliable where Self: AnyObject {
    public func apply(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

extension Array: Appliable {}
extension Calendar: Appliable {}
extension Dictionary: Appliable {}
extension JSONDecoder: Appliable {}
extension JSONEncoder: Appliable {}
extension Set: Appliable {}

extension NSObject: Appliable {}
