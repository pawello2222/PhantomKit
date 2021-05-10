//
//  NSDecimalNumber+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 09.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension NSDecimalNumber {
    static func + (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.adding(rhs, withBehavior: NSDecimalNumberHandler.default)
    }

    static func - (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.subtracting(rhs, withBehavior: NSDecimalNumberHandler.default)
    }

    static func * (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.multiplying(by: rhs, withBehavior: NSDecimalNumberHandler.default)
    }

    static func / (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.dividing(by: rhs, withBehavior: NSDecimalNumberHandler.default)
    }
}

extension NSDecimalNumber {
    static func += (lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
        lhs = lhs + rhs
    }

    static func -= (lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
        lhs = lhs - rhs
    }

    static func *= (lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
        lhs = lhs * rhs
    }

    static func /= (lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
        lhs = lhs / rhs
    }
}

extension NSDecimalNumber {
    static func == (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return lhs.compare(rhs) == .orderedSame
    }

    static func < (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return lhs.compare(rhs) == .orderedAscending
    }

    static func > (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return lhs.compare(rhs) == .orderedDescending
    }

    static func <= (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return [.orderedAscending, .orderedSame].contains(lhs.compare(rhs))
    }

    static func >= (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return [.orderedDescending, .orderedSame].contains(lhs.compare(rhs))
    }
}

extension NSDecimalNumber {
    public func rounded(toPlaces decimals: Int) -> NSDecimalNumber {
        rounding(accordingToBehavior: NSDecimalNumberHandler.scaled(decimals))
    }
}

extension NSDecimalNumberHandler {
    public static var `default`: NSDecimalNumberHandler = .scaled(16)

    fileprivate static func scaled(_ scale: Int) -> NSDecimalNumberHandler {
        .init(
            roundingMode: .plain,
            scale: Int16(scale),
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: false
        )
    }
}
