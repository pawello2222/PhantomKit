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
@testable import PhantomKitCore

class CGSizeTests: XCTestCase {
    override func setUpWithError() throws {}
}

// MARK: - Tests: Convenience

extension CGSizeTests {
    func test_init_length() throws {
        let size = CGSize(length: 100)

        XCTAssertEqual(size.width, 100)
        XCTAssertEqual(size.height, 100)
    }
}

// MARK: - Tests: Helpers

extension CGSizeTests {
    func test_min() throws {
        let size = CGSize(width: 100, height: 200)

        XCTAssertEqual(size.min, 100)
    }

    func test_max() throws {
        let size = CGSize(width: 100, height: 200)

        XCTAssertEqual(size.max, 200)
    }
}

// MARK: - Tests: Operators

extension CGSizeTests {
    func test_addCGFloat() throws {
        var lhs = CGSize(width: 200, height: 100)
        let rhs = CGFloat(10)
        let result = CGSize(width: 210, height: 110)

        XCTAssertEqual(lhs + rhs, result)

        lhs += rhs
        XCTAssertEqual(lhs, result)
    }

    func test_addCGSize() throws {
        var lhs = CGSize(width: 200, height: 100)
        let rhs = CGSize(width: 20, height: 30)
        let result = CGSize(width: 220, height: 130)

        XCTAssertEqual(lhs + rhs, result)

        lhs += rhs
        XCTAssertEqual(lhs, result)
    }

    func test_subtractCGFloat() throws {
        var lhs = CGSize(width: 200, height: 100)
        let rhs = CGFloat(10)
        let result = CGSize(width: 190, height: 90)

        XCTAssertEqual(lhs - rhs, result)

        lhs -= rhs
        XCTAssertEqual(lhs, result)
    }

    func test_subtractCGSize() throws {
        var lhs = CGSize(width: 200, height: 100)
        let rhs = CGSize(width: 20, height: 30)
        let result = CGSize(width: 180, height: 70)

        XCTAssertEqual(lhs - rhs, result)

        lhs -= rhs
        XCTAssertEqual(lhs, result)
    }

    func test_multiplyByCGFloat() throws {
        var lhs = CGSize(width: 200, height: 100)
        let rhs = CGFloat(2)
        let result = CGSize(width: 400, height: 200)

        XCTAssertEqual(lhs * rhs, result)

        lhs *= rhs
        XCTAssertEqual(lhs, result)
    }

    func test_multiplyByCGSize() throws {
        var lhs = CGSize(width: 200, height: 100)
        let rhs = CGSize(width: 2, height: 3)
        let result = CGSize(width: 400, height: 300)

        XCTAssertEqual(lhs * rhs, result)

        lhs *= rhs
        XCTAssertEqual(lhs, result)
    }
}
