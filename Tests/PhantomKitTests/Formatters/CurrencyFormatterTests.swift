//
//  CurrencyFormatterTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 09.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Nimble
import XCTest
@testable import PhantomKit

class CurrencyFormatterTests: XCTestCase {
    let usFormatter = LocalizedFormatter.makeCurrencyFormatter(
        locale: .init(identifier: "en_US"),
        currencyCode: "USD"
    )

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_currencyFormatter_shouldFormatAmounts() throws {
        expect(self.usFormatter.string(from: 1)).to(equal("$1.00"))
        expect(self.usFormatter.string(from: 432)).to(equal("$432.00"))
        expect(self.usFormatter.string(from: 1000)).to(equal("$1,000.00"))
        expect(self.usFormatter.string(from: 48_729_432)).to(equal("$48,729,432.00"))
    }

    func test_currencyFormatter_shouldFormatNegativeAmounts() throws {
        expect(self.usFormatter.string(from: -1)).to(equal("-$1.00"))
        expect(self.usFormatter.string(from: -432)).to(equal("-$432.00"))
        expect(self.usFormatter.string(from: -1000)).to(equal("-$1,000.00"))
        expect(self.usFormatter.string(from: -48_729_432)).to(equal("-$48,729,432.00"))
    }

    func test_currencyFormatter_withLocalePLPL_shouldFormatAmountsToPLN() throws {
        let plFormatter = LocalizedFormatter.makeCurrencyFormatter(
            locale: .init(identifier: "pl_PL"),
            currencyCode: "PLN"
        )

        expect(plFormatter.string(from: 1)).to(equal("1,00 zł"))
        expect(plFormatter.string(from: 432)).to(equal("432,00 zł"))
        expect(plFormatter.string(from: 1000)).to(equal("1000,00 zł"))
        expect(plFormatter.string(from: 48_729_432)).to(equal("48 729 432,00 zł"))
    }

    func test_currencyFormatter_withLocaleENPL_shouldFormatAmountsToPLN() throws {
        let plFormatter = LocalizedFormatter.makeCurrencyFormatter(
            locale: .init(identifier: "en_PL"),
            currencyCode: "PLN"
        )

        expect(plFormatter.string(from: 1)).to(equal("1,00 PLN"))
        expect(plFormatter.string(from: 432)).to(equal("432,00 PLN"))
        expect(plFormatter.string(from: 1000)).to(equal("1 000,00 PLN"))
        expect(plFormatter.string(from: 48_729_432)).to(equal("48 729 432,00 PLN"))
    }

    func test_currencyFormatter_withLocalePLPL_shouldFormatNegativeAmountsToPLN() throws {
        let plFormatter = LocalizedFormatter.makeCurrencyFormatter(
            locale: .init(identifier: "pl_PL"),
            currencyCode: "PLN"
        )

        expect(plFormatter.string(from: -1)).to(equal("-1,00 zł"))
        expect(plFormatter.string(from: -432)).to(equal("-432,00 zł"))
        expect(plFormatter.string(from: -1000)).to(equal("-1000,00 zł"))
        expect(plFormatter.string(from: -48_729_432)).to(equal("-48 729 432,00 zł"))
    }

    func test_currencyFormatter_withCurrencyCodePLN_shouldFormatNegativeAmountsToPLN() throws {
        let plFormatter = LocalizedFormatter.makeCurrencyFormatter(
            locale: .init(identifier: "en_US"),
            currencyCode: "PLN"
        )

        expect(plFormatter.string(from: -1)).to(equal("-PLN1.00"))
        expect(plFormatter.string(from: -432)).to(equal("-PLN432.00"))
        expect(plFormatter.string(from: -1000)).to(equal("-PLN1,000.00"))
        expect(plFormatter.string(from: -48_729_432)).to(equal("-PLN48,729,432.00"))
    }

    func test_currencyFormatter_withAbbreviation_shouldFormatAmounts() throws {
        expect(self.usFormatter.string(from: 326.09734, abbreviation: .default)).to(equal("$326.10"))
        expect(self.usFormatter.string(from: 1432.99, abbreviation: .default)).to(equal("$1.43k"))
        expect(self.usFormatter.string(from: 100_081, abbreviation: .default)).to(equal("$100.08k"))
        expect(self.usFormatter.string(from: 48_729_432, abbreviation: .default)).to(equal("$48.73m"))
        expect(self.usFormatter.string(from: -42.8111, abbreviation: .default)).to(equal("-$42.81"))
        expect(self.usFormatter.string(from: -4239.8111, abbreviation: .default)).to(equal("-$4.24k"))
    }

    func test_currencyFormatter_withLocalizedSign_shouldFormatAmounts() throws {
        expect(self.usFormatter.string(from: 123.456, sign: .none)).to(equal("$123.46"))
        expect(self.usFormatter.string(from: 123.456, sign: .default)).to(equal("$123.46"))
        expect(self.usFormatter.string(from: 123.456, sign: .both)).to(equal("+$123.46"))
        expect(self.usFormatter.string(from: -123.456, sign: .none)).to(equal("$123.46"))
        expect(self.usFormatter.string(from: -123.456, sign: .default)).to(equal("-$123.46"))
        expect(self.usFormatter.string(from: -123.456, sign: .both)).to(equal("-$123.46"))
    }

    func test_currencyFormatter_withCustomSign_shouldFormatAmounts() throws {
        let plus: LocalizedFormatter.Sign.Style = .custom("▲")
        let minus: LocalizedFormatter.Sign.Style = .custom("▼")

        let plusOnly: LocalizedFormatter.Sign = .init(plus: plus, minus: .none)
        let minusOnly: LocalizedFormatter.Sign = .init(plus: .none, minus: minus)
        let both: LocalizedFormatter.Sign = .init(plus: plus, minus: minus)

        expect(self.usFormatter.string(from: 123.456, sign: plusOnly)).to(equal("▲$123.46"))
        expect(self.usFormatter.string(from: -123.456, sign: plusOnly)).to(equal("$123.46"))
        expect(self.usFormatter.string(from: 123.456, sign: minusOnly)).to(equal("$123.46"))
        expect(self.usFormatter.string(from: -123.456, sign: minusOnly)).to(equal("▼$123.46"))
        expect(self.usFormatter.string(from: 123.456, sign: both)).to(equal("▲$123.46"))
        expect(self.usFormatter.string(from: -123.456, sign: both)).to(equal("▼$123.46"))
    }
}
