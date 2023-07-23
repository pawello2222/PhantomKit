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

class DateComponentsFormatterTests: XCTestCase {
    func test_shouldFormatTimeInterval() throws {
        let usFormatter = LocalizedFormatter.dateComponents(locale: .init(identifier: "en_US"))

        XCTAssertEqual(usFormatter.string(fromTimeInterval: 10), "10 seconds")
    }

    func test_withLocalePL_shouldFormatTimeInterval() throws {
        let plFormatter = LocalizedFormatter.dateComponents(locale: .init(identifier: "pl_PL"))

        XCTAssertEqual(plFormatter.string(fromTimeInterval: 10), "10 sekund")
    }

    func test_shouldFormatDateFromTo() throws {
        let usFormatter = LocalizedFormatter.dateComponents(locale: .init(identifier: "en_US"))
        let now = Date()
        let future = now.adjusting(.minute, by: 5)
        XCTAssertEqual(usFormatter.string(from: now, to: future), "5 minutes")
    }

    func test_shouldFormatDateComponents() throws {
        let usFormatter = LocalizedFormatter.dateComponents(locale: .init(identifier: "en_US"))
        let date = Date(year: 2000, month: 3, day: 24, hour: 16, minute: 14, second: 44)
        let components = date.components([.hour, .minute])
        XCTAssertEqual(usFormatter.string(from: components), "16 hours, 14 minutes")
    }

    func test_withUnitsDate_shouldFormatDateFromTo() throws {
        let usFormatter = LocalizedFormatter.dateComponents(locale: .init(identifier: "en_US"))
        let now = Date()
        XCTAssertEqual(usFormatter.string(from: now, to: now.adjusting(.day, by: 2)), "48 hours")
        XCTAssertEqual(usFormatter.string(from: now, to: now.adjusting(.minute, by: 5)), "5 minutes")
    }

    func test_withUnitsDatetime_shouldFormatDateFromTo() throws {
        let usFormatter = LocalizedFormatter.dateComponents(locale: .init(identifier: "en_US"))
        let now = Date()
        let future = now.adjusting(.minute, by: 5)
        XCTAssertEqual(usFormatter.string(from: now, to: future), "5 minutes")
    }
}
