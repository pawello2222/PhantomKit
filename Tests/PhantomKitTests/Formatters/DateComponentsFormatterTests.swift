//
//  DateComponentsFormatterTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import XCTest
@testable import PhantomKit

class DateComponentsFormatterTests: XCTestCase {
    func test_dateComponentsFormatter_shouldFormatTimeInterval() throws {
        let usFormatter = LocalizedDateFormatter.dateComponents(locale: .init(identifier: "en_US"))

        XCTAssertEqual(usFormatter.string(from: TimeInterval(10)), "10 seconds")
    }

    func test_dateComponentsFormatter_withLocalePL_shouldFormatTimeInterval() throws {
        let plFormatter = LocalizedDateFormatter.dateComponents(locale: .init(identifier: "pl_PL"))

        XCTAssertEqual(plFormatter.string(from: TimeInterval(10)), "10 sekund")
    }

    func test_dateComponentsFormatter_shouldFormatDateFromTo() throws {
        let usFormatter = LocalizedDateFormatter.dateComponents(locale: .init(identifier: "en_US"))
        let now = Date()
        let future = now.adjusting(.minute, by: 5)
        XCTAssertEqual(usFormatter.string(from: now, to: future), "5 minutes")
    }

    func test_dateComponentsFormatter_shouldFormatDateComponents() throws {
        let usFormatter = LocalizedDateFormatter.dateComponents(locale: .init(identifier: "en_US"))
        let date = Date(year: 2000, month: 3, day: 24, hour: 16, minute: 14, second: 44)
        let components = date.dateComponents([.hour, .minute])
        XCTAssertEqual(usFormatter.string(from: components), "16 hours, 14 minutes")
    }

    func test_dateComponentsFormatter_withUnitsDate_shouldFormatDateFromTo() throws {
        let usFormatter = LocalizedDateFormatter.dateComponents(locale: .init(identifier: "en_US"))
        let now = Date()
        XCTAssertEqual(usFormatter.string(from: now, to: now.adjusting(.day, by: 2)), "48 hours")
        XCTAssertEqual(usFormatter.string(from: now, to: now.adjusting(.minute, by: 5)), "5 minutes")
    }

    func test_dateComponentsFormatter_withUnitsDatetime_shouldFormatDateFromTo() throws {
        let usFormatter = LocalizedDateFormatter.dateComponents(locale: .init(identifier: "en_US"))
        let now = Date()
        let future = now.adjusting(.minute, by: 5)
        XCTAssertEqual(usFormatter.string(from: now, to: future), "5 minutes")
    }
}
