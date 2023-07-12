//
//  CurrencyFormatterTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 09.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import XCTest
@testable import PhantomKit

class CurrencyFormatterTests: XCTestCase {
    private let usFormatter = LocalizedFormatter.currency(
        locale: .init(identifier: "en_US"),
        currencyCode: "USD"
    )

    func test_currencyFormatter_shouldFormatAmounts() throws {
        XCTAssertEqual(usFormatter.string(from: 1), "$1.00")
        XCTAssertEqual(usFormatter.string(from: 432), "$432.00")
        XCTAssertEqual(usFormatter.string(from: 1000), "$1,000.00")
        XCTAssertEqual(usFormatter.string(from: 48_729_432), "$48,729,432.00")
    }

    func test_currencyFormatter_shouldFormatNegativeAmounts() throws {
        XCTAssertEqual(usFormatter.string(from: -1), "-$1.00")
        XCTAssertEqual(usFormatter.string(from: -432), "-$432.00")
        XCTAssertEqual(usFormatter.string(from: -1000), "-$1,000.00")
        XCTAssertEqual(usFormatter.string(from: -48_729_432), "-$48,729,432.00")
    }

    func test_currencyFormatter_withLocalePLPL_shouldFormatAmountsToPLN() throws {
        let plFormatter = LocalizedFormatter.currency(
            locale: .init(identifier: "pl_PL"),
            currencyCode: "PLN"
        )

        XCTAssertEqual(plFormatter.string(from: 1), "1,00 zł")
        XCTAssertEqual(plFormatter.string(from: 432), "432,00 zł")
        XCTAssertEqual(plFormatter.string(from: 1000), "1000,00 zł")
        XCTAssertEqual(plFormatter.string(from: 48_729_432), "48 729 432,00 zł")
    }

    func test_currencyFormatter_withLocaleENPL_shouldFormatAmountsToPLN() throws {
        let plFormatter = LocalizedFormatter.currency(
            locale: .init(identifier: "en_PL"),
            currencyCode: "PLN"
        )

        XCTAssertEqual(plFormatter.string(from: 1), "1,00 PLN")
        XCTAssertEqual(plFormatter.string(from: 432), "432,00 PLN")
        XCTAssertEqual(plFormatter.string(from: 1000), "1 000,00 PLN")
        XCTAssertEqual(plFormatter.string(from: 48_729_432), "48 729 432,00 PLN")
    }

    func test_currencyFormatter_withLocalePLPL_shouldFormatNegativeAmountsToPLN() throws {
        let plFormatter = LocalizedFormatter.currency(
            locale: .init(identifier: "pl_PL"),
            currencyCode: "PLN"
        )

        XCTAssertEqual(plFormatter.string(from: -1), "-1,00 zł")
        XCTAssertEqual(plFormatter.string(from: -432), "-432,00 zł")
        XCTAssertEqual(plFormatter.string(from: -1000), "-1000,00 zł")
        XCTAssertEqual(plFormatter.string(from: -48_729_432), "-48 729 432,00 zł")
    }

    func test_currencyFormatter_withCurrencyCodePLN_shouldFormatNegativeAmountsToPLN() throws {
        let plFormatter = LocalizedFormatter.currency(
            locale: .init(identifier: "en_US"),
            currencyCode: "PLN"
        )

        XCTAssertEqual(plFormatter.string(from: -1), "-PLN1.00")
        XCTAssertEqual(plFormatter.string(from: -432), "-PLN432.00")
        XCTAssertEqual(plFormatter.string(from: -1000), "-PLN1,000.00")
        XCTAssertEqual(plFormatter.string(from: -48_729_432), "-PLN48,729,432.00")
    }

    func test_currencyFormatter_withAbbreviation_shouldFormatAmounts() throws {
        XCTAssertEqual(usFormatter.string(from: 326.09734, abbreviation: .default), "$326.10")
        XCTAssertEqual(usFormatter.string(from: 1432.99, abbreviation: .default), "$1.43k")
        XCTAssertEqual(usFormatter.string(from: 100_081, abbreviation: .default), "$100.08k")
        XCTAssertEqual(usFormatter.string(from: 48_729_432, abbreviation: .default), "$48.73m")
        XCTAssertEqual(usFormatter.string(from: -42.8111, abbreviation: .default), "-$42.81")
        XCTAssertEqual(usFormatter.string(from: -4239.8111, abbreviation: .default), "-$4.24k")
    }

    func test_currencyFormatter_withLocalizedSign_shouldFormatAmounts() throws {
        XCTAssertEqual(usFormatter.string(from: 123.456, sign: .none), "$123.46")
        XCTAssertEqual(usFormatter.string(from: 123.456, sign: .default), "$123.46")
        XCTAssertEqual(usFormatter.string(from: 123.456, sign: .both), "+$123.46")
        XCTAssertEqual(usFormatter.string(from: -123.456, sign: .none), "$123.46")
        XCTAssertEqual(usFormatter.string(from: -123.456, sign: .default), "-$123.46")
        XCTAssertEqual(usFormatter.string(from: -123.456, sign: .both), "-$123.46")
    }

    func test_currencyFormatter_withCustomSign_shouldFormatAmounts() throws {
        let plus: LocalizedFormatter.Sign.Style = .custom("▲")
        let minus: LocalizedFormatter.Sign.Style = .custom("▼")

        let plusOnly: LocalizedFormatter.Sign = .init(plus: plus, minus: .none)
        let minusOnly: LocalizedFormatter.Sign = .init(plus: .none, minus: minus)
        let both: LocalizedFormatter.Sign = .init(plus: plus, minus: minus)

        XCTAssertEqual(usFormatter.string(from: 123.456, sign: plusOnly), "▲$123.46")
        XCTAssertEqual(usFormatter.string(from: -123.456, sign: plusOnly), "$123.46")
        XCTAssertEqual(usFormatter.string(from: 123.456, sign: minusOnly), "$123.46")
        XCTAssertEqual(usFormatter.string(from: -123.456, sign: minusOnly), "▼$123.46")
        XCTAssertEqual(usFormatter.string(from: 123.456, sign: both), "▲$123.46")
        XCTAssertEqual(usFormatter.string(from: -123.456, sign: both), "▼$123.46")
    }
}
