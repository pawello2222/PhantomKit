//
//  NSDecimalNumberTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

import Nimble
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

        expect(lhs + rhs).to(equal(result))

        lhs += rhs
        expect(lhs).to(equal(result))
    }

    func test_nsDecimalNumber_shouldSubtractNumbers() throws {
        var lhs = NSDecimalNumber(string: "1.23")
        let rhs = NSDecimalNumber(string: "3.41")
        let result = NSDecimalNumber(string: "-2.18")

        expect(lhs - rhs).to(equal(result))

        lhs -= rhs
        expect(lhs).to(equal(result))
    }

    func test_nsDecimalNumber_shouldMultiplyNumbers() throws {
        var lhs = NSDecimalNumber(string: "1.23")
        let rhs = NSDecimalNumber(string: "3.41")
        let result = NSDecimalNumber(string: "4.1943")

        expect(lhs * rhs).to(equal(result))

        lhs *= rhs
        expect(lhs).to(equal(result))
    }

    func test_nsDecimalNumber_shouldDivideNumbers() throws {
        var lhs = NSDecimalNumber(string: "1.23")
        let rhs = NSDecimalNumber(string: "3.41")
        let result = NSDecimalNumber(string: "0.36070381")

        expect(lhs / rhs).to(equal(result))

        lhs /= rhs
        expect(lhs).to(equal(result))
    }

    func test_nsDecimalNumber_onDivideByZero_shouldNotRaise() throws {
        var lhs = NSDecimalNumber(string: "1.23")
        let rhs = NSDecimalNumber(string: "0")
        let result = NSDecimalNumber.notANumber

        expect(lhs / rhs).to(equal(result))

        lhs /= rhs
        expect(lhs).to(equal(result))
    }

    func test_nsDecimalNumber_shouldCompareNumbers() throws {
        let a = NSDecimalNumber(string: "-1.23")
        let b = NSDecimalNumber(string: "0.437")
        let c = NSDecimalNumber(string: "9.992")

        expect(a < b).to(beTrue())
        expect(a <= b).to(beTrue())
        expect(b < c).to(beTrue())
        expect(b <= c).to(beTrue())
        expect(a > b).to(beFalse())
        expect(a >= b).to(beFalse())
        expect(b > c).to(beFalse())
        expect(b >= c).to(beFalse())
        expect(a == c).to(beFalse())
        expect(b == c).to(beFalse())
    }
}
