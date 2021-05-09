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
    let formatter = LocalizedFormatter.makeCurrencyFormatter(
        locale: .init(identifier: "en_US"),
        currencyCode: "USD"
    )

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_currencyFormatter_shouldFormatToUSD() throws {
        expect(self.formatter.string(from: 1)).to(equal("$1.00"))
        expect(self.formatter.string(from: 432)).to(equal("$432.00"))
        expect(self.formatter.string(from: 1000)).to(equal("$1,000.00"))
        expect(self.formatter.string(from: 48_729_432)).to(equal("$48,729,432.00"))
    }

    func test_currencyFormatter_withLocalePLPL_shouldFormatToPLN() throws {
        let formatter = LocalizedFormatter.makeCurrencyFormatter(
            locale: .init(identifier: "pl_PL"),
            currencyCode: "PLN"
        )

        expect(formatter.string(from: 1)).to(equal("1,00 zł"))
        expect(formatter.string(from: 432)).to(equal("432,00 zł"))
        expect(formatter.string(from: 1000)).to(equal("1000,00 zł"))
        expect(formatter.string(from: 48_729_432)).to(equal("48 729 432,00 zł"))
    }

    func test_currencyFormatter_withLocaleENPL_shouldFormatToPLN() throws {
        let formatter = LocalizedFormatter.makeCurrencyFormatter(
            locale: .init(identifier: "en_PL"),
            currencyCode: "PLN"
        )

        expect(formatter.string(from: 1)).to(equal("1,00 PLN"))
        expect(formatter.string(from: 432)).to(equal("432,00 PLN"))
        expect(formatter.string(from: 1000)).to(equal("1 000,00 PLN"))
        expect(formatter.string(from: 48_729_432)).to(equal("48 729 432,00 PLN"))
    }

    func test_currencyFormatter_withAbbreviation_shouldFormatToUSD() throws {
        expect(self.formatter.abbrString(from: 326.09734)).to(equal("$326.10"))
        expect(self.formatter.abbrString(from: 1432.99)).to(equal("$1.43k"))
        expect(self.formatter.abbrString(from: 100_081)).to(equal("$100.08k"))
        expect(self.formatter.abbrString(from: 48_729_432)).to(equal("$48.73m"))
    }
}
