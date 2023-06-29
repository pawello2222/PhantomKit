//
//  DateComponentsFormatterTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import Nimble
import XCTest
@testable import PhantomKit

class DateComponentsFormatterTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_dateComponentsFormatter_shouldFormatTimeInterval() throws {
        let usFormatter = LocalizedDateFormatter.dateComponents(locale: .init(identifier: "en_US"))

        expect(usFormatter.string(from: TimeInterval(10))).to(equal("10 seconds"))
    }

    func test_dateComponentsFormatter_withLocalePL_shouldFormatTimeInterval() throws {
        let plFormatter = LocalizedDateFormatter.dateComponents(locale: .init(identifier: "pl_PL"))

        expect(plFormatter.string(from: TimeInterval(10))).to(equal("10 sekund"))
    }

    func test_dateComponentsFormatter_shouldFormatDateFromTo() throws {
        let usFormatter = LocalizedDateFormatter.dateComponents(locale: .init(identifier: "en_US"))
        let now = Date()
        let future = now.adjusting(.minute, by: 5)
        expect(usFormatter.string(from: now, to: future)).to(equal("5 minutes"))
    }

    func test_dateComponentsFormatter_shouldFormatDateComponents() throws {
        let usFormatter = LocalizedDateFormatter.dateComponents(locale: .init(identifier: "en_US"))
        let date = Date(year: 2000, month: 3, day: 24, hour: 16, minute: 14, second: 44)
        let components = date.dateComponents([.hour, .minute])
        expect(usFormatter.string(from: components)).to(equal("16 hours, 14 minutes"))
    }

    func test_dateComponentsFormatter_withUnitsDate_shouldFormatDateFromTo() throws {
        let usFormatter = LocalizedDateFormatter.dateComponents(locale: .init(identifier: "en_US"))
        let now = Date()
        expect(usFormatter.string(from: now, to: now.adjusting(.day, by: 2))).to(equal("48 hours"))
        expect(usFormatter.string(from: now, to: now.adjusting(.minute, by: 5))).to(equal("5 minutes"))
    }

    func test_dateComponentsFormatter_withUnitsDatetime_shouldFormatDateFromTo() throws {
        let usFormatter = LocalizedDateFormatter.dateComponents(locale: .init(identifier: "en_US"))
        let now = Date()
        let future = now.adjusting(.minute, by: 5)
        expect(usFormatter.string(from: now, to: future)).to(equal("5 minutes"))
    }
}
