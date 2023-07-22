// The MIT License (MIT)
//
// Copyright (c) 2021-Present Paweł Wiszenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
