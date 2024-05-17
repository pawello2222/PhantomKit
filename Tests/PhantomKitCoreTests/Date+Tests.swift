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

class DateTests: XCTestCase {
    override func setUpWithError() throws {}
}

// MARK: - Tests: Adjustment

extension DateTests {
    func test_adjustingComponent() throws {
        let date = Date(year: 2000, month: 1, day: 2, hour: 3, minute: 4, second: 5)

        XCTAssertEqual(date.adjusting(\.second, by: 1).component(.second), 6)
        XCTAssertEqual(date.adjusting(\.minute, by: 1).component(.minute), 5)
        XCTAssertEqual(date.adjusting(\.hour, by: 1).component(.hour), 4)
        XCTAssertEqual(date.adjusting(\.day, by: 1).component(.day), 3)
        XCTAssertEqual(date.adjusting(\.month, by: 1).component(.month), 2)
        XCTAssertEqual(date.adjusting(\.year, by: 1).component(.year), 2001)
    }

    func test_startOfComponent() throws {
        let date = Date(year: 2000, month: 2, day: 3, hour: 4, minute: 5, second: 6)

        XCTAssertEqual(date.startOf(.second), Date(year: 2000, month: 2, day: 3, hour: 4, minute: 5, second: 6))
        XCTAssertEqual(date.startOf(.minute), Date(year: 2000, month: 2, day: 3, hour: 4, minute: 5, second: 0))
        XCTAssertEqual(date.startOf(.hour), Date(year: 2000, month: 2, day: 3, hour: 4, minute: 0, second: 0))
        XCTAssertEqual(date.startOf(.day), Date(year: 2000, month: 2, day: 3, hour: 0, minute: 0, second: 0))
        XCTAssertEqual(date.startOf(.month), Date(year: 2000, month: 2, day: 1, hour: 0, minute: 0, second: 0))
        XCTAssertEqual(date.startOf(.year), Date(year: 2000, month: 1, day: 1, hour: 0, minute: 0, second: 0))
    }

    func test_endOfComponent() throws {
        let interval: TimeInterval = -0.001
        let date = Date(year: 2000, month: 2, day: 3, hour: 4, minute: 5, second: 6)

        XCTAssertEqual(
            date.endOf(.second),
            Date(timeInterval: interval, since: Date(year: 2000, month: 2, day: 3, hour: 4, minute: 5, second: 7))
        )
        XCTAssertEqual(
            date.endOf(.minute),
            Date(timeInterval: interval, since: Date(year: 2000, month: 2, day: 3, hour: 4, minute: 6, second: 0))
        )
        XCTAssertEqual(
            date.endOf(.hour),
            Date(timeInterval: interval, since: Date(year: 2000, month: 2, day: 3, hour: 5, minute: 0, second: 0))
        )
        XCTAssertEqual(
            date.endOf(.day),
            Date(timeInterval: interval, since: Date(year: 2000, month: 2, day: 4, hour: 0, minute: 0, second: 0))
        )
        XCTAssertEqual(
            date.endOf(.month),
            Date(timeInterval: interval, since: Date(year: 2000, month: 3, day: 1, hour: 0, minute: 0, second: 0))
        )
        XCTAssertEqual(
            date.endOf(.year),
            Date(timeInterval: interval, since: Date(year: 2001, month: 1, day: 1, hour: 0, minute: 0, second: 0))
        )
    }
}

// MARK: - Tests: Comparison

extension DateTests {}

// MARK: - Tests: Components

extension DateTests {
    func test_shouldReturnComponents() throws {
        let calendar: Calendar = .iso
        let date = Date(year: 2000, month: 1, day: 2, hour: 3, minute: 4, second: 5)

        let components = date.components([.hour, .minute], in: calendar)
        let expectatedComponents = calendar.dateComponents([.hour, .minute], from: date)

        XCTAssertEqual(components, expectatedComponents)
    }
}

// MARK: - Tests: Convenience

extension DateTests {
    func test_initWithComponents_shouldCreateDate() throws {
        let date = Date(year: 2000, month: 1, day: 2, hour: 3, minute: 4, second: 5)

        XCTAssertEqual(date.component(.year), 2000)
        XCTAssertEqual(date.component(.month), 1)
        XCTAssertEqual(date.component(.day), 2)
        XCTAssertEqual(date.component(.hour), 3)
        XCTAssertEqual(date.component(.minute), 4)
        XCTAssertEqual(date.component(.second), 5)
    }
}
