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

class ArrayTests: XCTestCase {
    func test_array_next_shouldReturnNextElementIfPresent() throws {
        let array = [1, 2, 3, 4, 5]

        XCTAssertEqual(array.next(ofIndex: 1), 3)
        XCTAssertEqual(array.next(ofIndex: 3), 5)
        XCTAssertNil(array.next(ofIndex: 4))
        XCTAssertNil(array.next(ofIndex: 5))

        XCTAssertEqual(array.next(of: 1), 2)
        XCTAssertEqual(array.next(of: 2), 3)
        XCTAssertNil(array.next(of: 5))
        XCTAssertNil(array.next(of: 6))
    }

    func test_array_nextLooped_shouldReturnNextElementOrFirst() throws {
        let array = [1, 2, 3, 4, 5]

        XCTAssertEqual(array.next(ofIndex: 3, looped: true), 5)
        XCTAssertEqual(array.next(ofIndex: 4, looped: true), 1)
        XCTAssertNil(array.next(ofIndex: 5, looped: true))

        XCTAssertEqual(array.next(of: 1, looped: true), 2)
        XCTAssertEqual(array.next(of: 2, looped: true), 3)
        XCTAssertEqual(array.next(of: 5, looped: true), 1)
        XCTAssertNil(array.next(of: 6, looped: true))
    }

    func test_array_toggleExistingElement_shouldRemoveElement() throws {
        var array = [1, 2, 3]

        array.toggle(3)
        XCTAssertTrue(array.contains(1))
        XCTAssertTrue(array.contains(2))
        XCTAssertFalse(array.contains(3))
        XCTAssertFalse(array.contains(4))
    }

    func test_array_toggleNonExistingElement_shouldAddElement() throws {
        var array = [1, 2, 3]

        array.toggle(4)
        XCTAssertTrue(array.contains(1))
        XCTAssertTrue(array.contains(2))
        XCTAssertTrue(array.contains(3))
        XCTAssertTrue(array.contains(4))
        XCTAssertFalse(array.contains(5))
    }

    func test_array_safeIndexSubscript_shouldNotThrowError() throws {
        let array = [1, 2, 3]

        XCTAssertEqual(array[safe: 0], 1)
        XCTAssertEqual(array[safe: 2], 3)
        XCTAssertNil(array[safe: 3])
        XCTAssertNil(array[safe: -1])
        XCTAssertNil(array[safe: 100])
        XCTAssertNil(array[safe: -100])
    }

    func test_array_safeRangeSubscript_shouldNotThrowError() throws {
        let array = [1, 2, 3]

        XCTAssertEqual(array[safe: 0 ..< 1], [1])
        XCTAssertEqual(array[safe: 0 ..< 3], [1, 2, 3])
        XCTAssertEqual(array[safe: -1 ..< 5], [1, 2, 3])
        XCTAssertEqual(array[safe: 2 ..< 100], [3])
        XCTAssertEqual(array[safe: -100 ..< 1], [1])
        XCTAssertEqual(array[safe: -100 ..< 0], [])
        XCTAssertEqual(array[safe: 3 ..< 100], [])
    }
}
