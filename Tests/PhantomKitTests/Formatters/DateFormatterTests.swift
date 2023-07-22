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

class DateFormatterTests: XCTestCase {
    func test_dateFormatter_shouldFormatDate() throws {
        let usFormatter = LocalizedDateFormatter.date(locale: .init(identifier: "en_US"))
        let date = Date(year: 2000, month: 3, day: 24)

        XCTAssertEqual(usFormatter.string(from: date), "03/24/2000")
    }

    func test_dateFormatter_withLocalePL_shouldFormatDate() throws {
        let plFormatter = LocalizedDateFormatter.date(locale: .init(identifier: "pl_PL"))
        let date = Date(year: 2000, month: 3, day: 24)

        XCTAssertEqual(plFormatter.string(from: date), "24.03.2000")
    }

    func test_dateFormatter_shouldFormatDateTime() throws {
        let usFormatter = LocalizedDateFormatter.date(
            locale: .init(identifier: "en_US"),
            localizedFormat: "yyyyMMddjjmmss"
        )
        let date = Date(year: 2000, month: 3, day: 24, hour: 16, minute: 14, second: 44)

        // For some reason the space before `PM` is different
        // depending on the platform
        let result = usFormatter.string(from: date)
        let expectations = [
            "03/24/2000, 4:14:44 PM",
            "03/24/2000, 4:14:44 PM"
        ]
        XCTAssertTrue(expectations.contains(result))
    }

    func test_dateFormatter_withLocalePL_shouldFormatDateTime() throws {
        let plFormatter = LocalizedDateFormatter.date(
            locale: .init(identifier: "pl_PL"),
            localizedFormat: "yyyyMMddjjmmss"
        )
        let date = Date(year: 2000, month: 3, day: 24, hour: 16, minute: 14, second: 44)

        XCTAssertEqual(plFormatter.string(from: date), "24.03.2000, 16:14:44")
    }

    func test_dateFormatter_withFixedFormat_shouldFormatDate() throws {
        let usFormatter = LocalizedDateFormatter.date(
            locale: .usPosix,
            format: "yyyy-MM-dd"
        )
        let date = Date(year: 2000, month: 3, day: 24)

        XCTAssertEqual(usFormatter.string(from: date), "2000-03-24")
    }

    func test_dateFormatter_withCustomTimeZone_shouldParseDate() throws {
        let usFormatter = LocalizedDateFormatter.date(
            locale: .usPosix,
            format: "HH:mm:ss"
        )
        let dateStr = "16:14:44"
        let date = Date(year: 2000, month: 1, day: 1, hour: 16, minute: 14, second: 44, calendar: .iso)

        XCTAssertEqual(usFormatter.date(from: dateStr, timeZone: .gmt), date)
    }

    func test_date_localizedString_shouldFormatDate() throws {
        let usFormatter = LocalizedDateFormatter.date(locale: .init(identifier: "en_US"))
        let date = Date(year: 2000, month: 3, day: 24)

        XCTAssertEqual(date.localizedString(formatter: usFormatter), "03/24/2000")
    }
}
