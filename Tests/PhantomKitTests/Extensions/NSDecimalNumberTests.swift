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

import XCTest
@testable import PhantomKit

class NSDecimalNumberTests: XCTestCase {
    override func setUpWithError() throws {
        NSDecimalNumberHandler.default = .scaled(8)
    }

    override func tearDownWithError() throws {
        NSDecimalNumberHandler.default = .scaled(16)
    }

    func test_shouldAddNumbers() throws {
        var lhs = NSDecimalNumber(string: "1.23")
        let rhs = NSDecimalNumber(string: "3.41")
        let result = NSDecimalNumber(string: "4.64")

        XCTAssertEqual(lhs + rhs, result)

        lhs += rhs
        XCTAssertEqual(lhs, result)
    }

    func test_shouldSubtractNumbers() throws {
        var lhs = NSDecimalNumber(string: "1.23")
        let rhs = NSDecimalNumber(string: "3.41")
        let result = NSDecimalNumber(string: "-2.18")

        XCTAssertEqual(lhs - rhs, result)

        lhs -= rhs
        XCTAssertEqual(lhs, result)
    }

    func test_shouldMultiplyNumbers() throws {
        var lhs = NSDecimalNumber(string: "1.23")
        let rhs = NSDecimalNumber(string: "3.41")
        let result = NSDecimalNumber(string: "4.1943")

        XCTAssertEqual(lhs * rhs, result)

        lhs *= rhs
        XCTAssertEqual(lhs, result)
    }

    func test_shouldDivideNumbers() throws {
        var lhs = NSDecimalNumber(string: "1.23")
        let rhs = NSDecimalNumber(string: "3.41")
        let result = NSDecimalNumber(string: "0.36070381")

        XCTAssertEqual(lhs / rhs, result)

        lhs /= rhs
        XCTAssertEqual(lhs, result)
    }

    func test_onDivideByZero_shouldNotRaise() throws {
        var lhs = NSDecimalNumber(string: "1.23")
        let rhs = NSDecimalNumber(string: "0")
        let result = NSDecimalNumber.notANumber

        XCTAssertEqual(lhs / rhs, result)

        lhs /= rhs
        XCTAssertEqual(lhs, result)
    }

    func test_shouldCompareNumbers() throws {
        // swiftlint:disable identifier_name
        let a = NSDecimalNumber(string: "-1.23")
        let b = NSDecimalNumber(string: "0.437")
        let c = NSDecimalNumber(string: "9.992")
        // swiftlint:enable identifier_name

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

    func test_shouldRoundZero() throws {
        let number = NSDecimalNumber(string: "-123.456789")

        XCTAssertEqual(number.rounded(toPlaces: 4), NSDecimalNumber(string: "-123.4568"))
    }

    func test_shouldReturnAbsoluteValue() throws {
        let number = NSDecimalNumber(string: "-123.456789")

        XCTAssertEqual(number.absValue, NSDecimalNumber(string: "123.456789"))
    }
}
