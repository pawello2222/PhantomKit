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

class DateTests: XCTestCase {
    func test_initWithComponents() throws {
        let date = Date(year: 2000, month: 1, day: 2, hour: 3, minute: 4, second: 5)

        XCTAssertEqual(date.component(.year), 2000)
        XCTAssertEqual(date.component(.month), 1)
        XCTAssertEqual(date.component(.day), 2)
        XCTAssertEqual(date.component(.hour), 3)
        XCTAssertEqual(date.component(.minute), 4)
        XCTAssertEqual(date.component(.second), 5)
    }

    func test_shouldAdjustDateByComponent() throws {
        let date = Date(year: 2000, month: 1, day: 2, hour: 3, minute: 4, second: 5)

        XCTAssertEqual(date.adjusting(\.second, by: 1).component(.second), 6)
        XCTAssertEqual(date.adjusting(\.minute, by: 1).component(.minute), 5)
        XCTAssertEqual(date.adjusting(\.hour, by: 1).component(.hour), 4)
        XCTAssertEqual(date.adjusting(\.day, by: 1).component(.day), 3)
        XCTAssertEqual(date.adjusting(\.month, by: 1).component(.month), 2)
        XCTAssertEqual(date.adjusting(\.year, by: 1).component(.year), 2001)
    }

    func test_shouldReturnComponents() throws {
        let calendar: Calendar = .iso
        let date = Date(year: 2000, month: 1, day: 2, hour: 3, minute: 4, second: 5)

        let components = date.components([.hour, .minute], in: calendar)
        let expectatedComponents = calendar.dateComponents([.hour, .minute], from: date)

        XCTAssertEqual(components, expectatedComponents)
    }
}
