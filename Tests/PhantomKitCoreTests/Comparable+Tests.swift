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

class ComparableTests: XCTestCase {
    override func setUpWithError() throws {}
}

// MARK: - Tests: Clamping

extension ComparableTests {
    func test_clamped() throws {
        XCTAssertEqual(1.clamped(to: 0...), 1)
        XCTAssertEqual(1.clamped(to: 1...), 1)
        XCTAssertEqual(1.clamped(to: 2...), 2)
        XCTAssertEqual(1.clamped(to: ...0), 0)
        XCTAssertEqual(1.clamped(to: ...1), 1)
        XCTAssertEqual(1.clamped(to: ...2), 1)
        XCTAssertEqual(1.clamped(to: 0 ... 2), 1)
        XCTAssertEqual(1.clamped(to: 2 ... 3), 2)
        XCTAssertEqual(1.clamped(to: -1 ... 0), 0)
        XCTAssertEqual(1.clamped(to: 1 ... 1), 1)
    }

    func test_clamp() throws {
        var value = 1
        value.clamp(to: 0...)
        XCTAssertEqual(value, 1)
        value.clamp(to: 2 ... 3)
        XCTAssertEqual(value, 2)
        value.clamp(to: ...0)
        XCTAssertEqual(value, 0)
    }
}
