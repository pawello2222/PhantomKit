//
//  DateFormatterTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 10.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Nimble
import XCTest
@testable import PhantomKit

class DateFormatterTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_dateFormatter_shouldFormatDate() throws {
        let usFormatter = LocalizedDateFormatter.makeDateFormatter(locale: .init(identifier: "en_US"))
        let date = Date(year: 2000, month: 3, day: 24)

        expect(usFormatter.string(from: date)).to(equal("03/24/2000"))
    }

    func test_dateFormatter_withLocalePL_shouldFormatDate() throws {
        let plFormatter = LocalizedDateFormatter.makeDateFormatter(locale: .init(identifier: "pl_PL"))
        let date = Date(year: 2000, month: 3, day: 24)

        expect(plFormatter.string(from: date)).to(equal("24.03.2000"))
    }

    func test_dateFormatter_shouldFormatDateTime() throws {
        let usFormatter = LocalizedDateFormatter.makeDateFormatter(
            locale: .init(identifier: "en_US"),
            localizedFormat: "yyyyMMddjjmmss"
        )
        let date = Date(year: 2000, month: 3, day: 24, hour: 16, minute: 14, second: 44)

        expect(usFormatter.string(from: date)).to(equal("03/24/2000, 4:14:44 PM"))
    }

    func test_dateFormatter_withLocalePL_shouldFormatDateTime() throws {
        let plFormatter = LocalizedDateFormatter.makeDateFormatter(
            locale: .init(identifier: "pl_PL"),
            localizedFormat: "yyyyMMddjjmmss"
        )
        let date = Date(year: 2000, month: 3, day: 24, hour: 16, minute: 14, second: 44)

        expect(plFormatter.string(from: date)).to(equal("24.03.2000, 16:14:44"))
    }

    func test_dateFormatter_shouldFormatDateComponents() throws {
        let usFormatter = LocalizedDateFormatter.makeDateComponentsFormatter(locale: .init(identifier: "en_US"))

        expect(usFormatter.string(from: TimeInterval(10))).to(equal("10 seconds"))
    }

    func test_dateFormatter_withLocalePL_shouldFormatDateComponents() throws {
        let plFormatter = LocalizedDateFormatter.makeDateComponentsFormatter(locale: .init(identifier: "pl_PL"))

        expect(plFormatter.string(from: TimeInterval(10))).to(equal("10 sekund"))
    }
}
