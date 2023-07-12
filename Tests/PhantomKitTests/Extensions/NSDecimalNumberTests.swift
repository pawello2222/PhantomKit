//
//  NSDecimalNumberTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import Foundation
import XCTest
@testable import PhantomKit

class NSDecimalNumberTests: XCTestCase {
    override func setUpWithError() throws {
        NSDecimalNumberHandler.default = .scaled(8)
    }

    override func tearDownWithError() throws {
        NSDecimalNumberHandler.default = .scaled(16)
    }

    func test_nsDecimalNumber_shouldAddNumbers() throws {
        var lhs = NSDecimalNumber(string: "1.23")
        let rhs = NSDecimalNumber(string: "3.41")
        let result = NSDecimalNumber(string: "4.64")

        XCTAssertEqual(lhs + rhs, result)

        lhs += rhs
        XCTAssertEqual(lhs, result)
    }

    func test_nsDecimalNumber_shouldSubtractNumbers() throws {
        var lhs = NSDecimalNumber(string: "1.23")
        let rhs = NSDecimalNumber(string: "3.41")
        let result = NSDecimalNumber(string: "-2.18")

        XCTAssertEqual(lhs - rhs, result)

        lhs -= rhs
        XCTAssertEqual(lhs, result)
    }

    func test_nsDecimalNumber_shouldMultiplyNumbers() throws {
        var lhs = NSDecimalNumber(string: "1.23")
        let rhs = NSDecimalNumber(string: "3.41")
        let result = NSDecimalNumber(string: "4.1943")

        XCTAssertEqual(lhs * rhs, result)

        lhs *= rhs
        XCTAssertEqual(lhs, result)
    }

    func test_nsDecimalNumber_shouldDivideNumbers() throws {
        var lhs = NSDecimalNumber(string: "1.23")
        let rhs = NSDecimalNumber(string: "3.41")
        let result = NSDecimalNumber(string: "0.36070381")

        XCTAssertEqual(lhs / rhs, result)

        lhs /= rhs
        XCTAssertEqual(lhs, result)
    }

    func test_nsDecimalNumber_onDivideByZero_shouldNotRaise() throws {
        var lhs = NSDecimalNumber(string: "1.23")
        let rhs = NSDecimalNumber(string: "0")
        let result = NSDecimalNumber.notANumber

        XCTAssertEqual(lhs / rhs, result)

        lhs /= rhs
        XCTAssertEqual(lhs, result)
    }

    // swiftlint:disable identifier_name
    func test_nsDecimalNumber_shouldCompareNumbers() throws {
        let a = NSDecimalNumber(string: "-1.23")
        let b = NSDecimalNumber(string: "0.437")
        let c = NSDecimalNumber(string: "9.992")

        XCTAssertTrue(a < b)
        XCTAssertTrue(a <= b)
        XCTAssertTrue(b < c)
        XCTAssertTrue(b <= c)
        XCTAssertFalse(a > b)
        XCTAssertFalse(a >= b)
        XCTAssertFalse(b > c)
        XCTAssertFalse(b >= c)
        XCTAssertFalse(a == c)
        XCTAssertFalse(b == c)
    }

    func test_nsDecimalNumber_shouldRoundZero() throws {
        let number = NSDecimalNumber(string: "-123.456789")

        XCTAssertEqual(number.rounded(toPlaces: 4), NSDecimalNumber(string: "-123.4568"))
    }

    func test_nsDecimalNumber_shouldReturnAbsoluteValue() throws {
        let number = NSDecimalNumber(string: "-123.456789")

        XCTAssertEqual(number.absValue, NSDecimalNumber(string: "123.456789"))
    }
}
