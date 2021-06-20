//
//  NSDecimalNumber+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 09.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension NSDecimalNumber {
    public static func + (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        lhs.adding(rhs, withBehavior: NSDecimalNumberHandler.default)
    }

    public static func - (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        lhs.subtracting(rhs, withBehavior: NSDecimalNumberHandler.default)
    }

    public static func * (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        lhs.multiplying(by: rhs, withBehavior: NSDecimalNumberHandler.default)
    }

    public static func / (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        lhs.dividing(by: rhs, withBehavior: NSDecimalNumberHandler.default)
    }
}

// swiftlint:disable shorthand_operator
extension NSDecimalNumber {
    public static func += (lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
        lhs = lhs + rhs
    }

    public static func -= (lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
        lhs = lhs - rhs
    }

    public static func *= (lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
        lhs = lhs * rhs
    }

    public static func /= (lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
        lhs = lhs / rhs
    }
}

extension NSDecimalNumber {
    public static func == (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        lhs.compare(rhs) == .orderedSame
    }

    public static func < (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        lhs.compare(rhs) == .orderedAscending
    }

    public static func > (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        lhs.compare(rhs) == .orderedDescending
    }

    public static func <= (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        lhs.compare(rhs).isContained(in: [.orderedAscending, .orderedSame])
    }

    public static func >= (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        lhs.compare(rhs).isContained(in: [.orderedDescending, .orderedSame])
    }
}

extension NSDecimalNumber {
    public func rounded(toPlaces decimals: Int) -> NSDecimalNumber {
        rounding(accordingToBehavior: NSDecimalNumberHandler.scaled(decimals))
    }
}

extension NSDecimalNumber {
    public var absValue: NSDecimalNumber {
        .init(decimal: decimalValue.magnitude)
    }
}

// MARK: - NSDecimalNumberHandler

extension NSDecimalNumberHandler {
    public static var `default`: NSDecimalNumberHandler = .scaled(16)

    public static func scaled(_ scale: Int) -> NSDecimalNumberHandler {
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
