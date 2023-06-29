//
//  DateFormatterTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 10.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import Nimble
import XCTest
@testable import PhantomKit

class DateFormatterTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_dateFormatter_shouldFormatDate() throws {
        let usFormatter = LocalizedDateFormatter.date(locale: .init(identifier: "en_US"))
        let date = Date(year: 2000, month: 3, day: 24)

        expect(usFormatter.string(from: date)).to(equal("03/24/2000"))
    }

    func test_dateFormatter_withLocalePL_shouldFormatDate() throws {
        let plFormatter = LocalizedDateFormatter.date(locale: .init(identifier: "pl_PL"))
        let date = Date(year: 2000, month: 3, day: 24)

        expect(plFormatter.string(from: date)).to(equal("24.03.2000"))
    }

    func test_dateFormatter_shouldFormatDateTime() throws {
        let usFormatter = LocalizedDateFormatter.date(
            locale: .init(identifier: "en_US"),
            localizedFormat: "yyyyMMddjjmmss"
        )
        let date = Date(year: 2000, month: 3, day: 24, hour: 16, minute: 14, second: 44)

        expect(usFormatter.string(from: date)).to(equal("03/24/2000, 4:14:44 PM"))
    }

    func test_dateFormatter_withLocalePL_shouldFormatDateTime() throws {
        let plFormatter = LocalizedDateFormatter.date(
            locale: .init(identifier: "pl_PL"),
            localizedFormat: "yyyyMMddjjmmss"
        )
        let date = Date(year: 2000, month: 3, day: 24, hour: 16, minute: 14, second: 44)

        expect(plFormatter.string(from: date)).to(equal("24.03.2000, 16:14:44"))
    }

    func test_dateFormatter_withFixedFormat_shouldFormatDate() throws {
        let usFormatter = LocalizedDateFormatter.date(
            locale: .usPosix,
            format: "yyyy-MM-dd"
        )
        let date = Date(year: 2000, month: 3, day: 24)

        expect(usFormatter.string(from: date)).to(equal("2000-03-24"))
    }

    func test_dateFormatter_withCustomTimeZone_shouldParseDate() throws {
        let usFormatter = LocalizedDateFormatter.date(
            locale: .usPosix,
            format: "HH:mm:ss"
        )
        let dateStr = "16:14:44"
        let date = Date(year: 2000, month: 1, day: 1, hour: 16, minute: 14, second: 44, calendar: .iso)

        expect(usFormatter.date(from: dateStr, timeZone: .gmt)).to(equal(date))
    }

    func test_date_localizedString_shouldFormatDate() throws {
        let usFormatter = LocalizedDateFormatter.date(locale: .init(identifier: "en_US"))
        let date = Date(year: 2000, month: 3, day: 24)

        expect(date.localizedString(formatter: usFormatter)).to(equal("03/24/2000"))
    }
}
