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

        expect(plFormatter.string(from: -1)).to(equal("-PLN 1.00"))
        expect(plFormatter.string(from: -432)).to(equal("-PLN 432.00"))
        expect(plFormatter.string(from: -1000)).to(equal("-PLN 1,000.00"))
        expect(plFormatter.string(from: -48_729_432)).to(equal("-PLN 48,729,432.00"))
    }

    func test_currencyFormatter_withAbbreviation_shouldFormatAmounts() throws {
        expect(self.usFormatter.string(from: 326.09734, abbreviated: true)).to(equal("$326.10"))
        expect(self.usFormatter.string(from: 1432.99, abbreviated: true)).to(equal("$1.43k"))
        expect(self.usFormatter.string(from: 100_081, abbreviated: true)).to(equal("$100.08k"))
        expect(self.usFormatter.string(from: 48_729_432, abbreviated: true)).to(equal("$48.73m"))
    }
}
