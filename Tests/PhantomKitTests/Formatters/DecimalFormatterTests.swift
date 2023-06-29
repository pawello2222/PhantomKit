//
//  DecimalFormatterTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 09.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import Nimble
import XCTest
@testable import PhantomKit

class DecimalFormatterTests: XCTestCase {
    let usFormatter = LocalizedFormatter.decimal(locale: .init(identifier: "en_US"))

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_decimalFormatter_shouldFormatIntegers() throws {
        expect(self.usFormatter.string(from: 1)).to(equal("1"))
        expect(self.usFormatter.string(from: 432)).to(equal("432"))
        expect(self.usFormatter.string(from: 1000)).to(equal("1,000"))
        expect(self.usFormatter.string(from: 48_729_432)).to(equal("48,729,432"))
    }

    func test_decimalFormatter_withLocalePL_shouldFormatIntegers() throws {
        let plFormatter = LocalizedFormatter.decimal(locale: .init(identifier: "pl_PL"))

        expect(plFormatter.string(from: 1)).to(equal("1"))
        expect(plFormatter.string(from: 432)).to(equal("432"))
        expect(plFormatter.string(from: 1000)).to(equal("1000"))
        expect(plFormatter.string(from: 48_729_432)).to(equal("48 729 432"))
    }

    func test_decimalFormatter_shouldFormatNegativeIntegers() throws {
        expect(self.usFormatter.string(from: -1)).to(equal("-1"))
        expect(self.usFormatter.string(from: -432)).to(equal("-432"))
        expect(self.usFormatter.string(from: -1000)).to(equal("-1,000"))
        expect(self.usFormatter.string(from: -48_729_432)).to(equal("-48,729,432"))
    }

    func test_decimalFormatter_withAbbreviation_shouldFormatIntegers() throws {
        expect(self.usFormatter.string(from: 1, abbreviation: .default)).to(equal("1"))
        expect(self.usFormatter.string(from: 432, abbreviation: .default)).to(equal("432"))
        expect(self.usFormatter.string(from: 1000, abbreviation: .default)).to(equal("1k"))
        expect(self.usFormatter.string(from: 48_729_432, abbreviation: .default)).to(equal("48.73m"))
    }

    func test_decimalFormatter_withAbbreviationCapitalized_shouldFormatIntegers() throws {
        expect(self.usFormatter.string(from: 1, abbreviation: .capitalized)).to(equal("1"))
        expect(self.usFormatter.string(from: 432, abbreviation: .capitalized)).to(equal("432"))
        expect(self.usFormatter.string(from: 1000, abbreviation: .capitalized)).to(equal("1K"))
        expect(self.usFormatter.string(from: 48_729_432, abbreviation: .capitalized)).to(equal("48.73M"))
    }

    func test_decimalFormatter_shouldFormatDecimals() throws {
        expect(self.usFormatter.string(from: 0.648723)).to(equal("0.65"))
        expect(self.usFormatter.string(from: Float(0.648723))).to(equal("0.65"))
        expect(self.usFormatter.string(from: Decimal(0.648723))).to(equal("0.65"))
        expect(self.usFormatter.string(from: 12.53)).to(equal("12.53"))
        expect(self.usFormatter.string(from: 123.000)).to(equal("123"))
        expect(self.usFormatter.string(from: 6_723_846.5673658)).to(equal("6,723,846.57"))
    }

    func test_decimalFormatter_withLocalePL_shouldFormatDecimals() throws {
        let plFormatter = LocalizedFormatter.decimal(locale: .init(identifier: "pl_PL"))

        expect(plFormatter.string(from: 0.648723)).to(equal("0,65"))
        expect(plFormatter.string(from: 12.53)).to(equal("12,53"))
        expect(plFormatter.string(from: 123.000)).to(equal("123"))
        expect(plFormatter.string(from: 6_723_846.5673658)).to(equal("6 723 846,57"))
    }

    func test_decimalFormatter_withAbbreviation_shouldFormatDecimals() throws {
        expect(self.usFormatter.string(from: 0.648723, abbreviation: .default)).to(equal("0.65"))
        expect(self.usFormatter.string(from: 12.53, abbreviation: .default)).to(equal("12.53"))
        expect(self.usFormatter.string(from: 123_000.01, abbreviation: .default)).to(equal("123k"))
        expect(self.usFormatter.string(from: 6_723_846.5673658, abbreviation: .default)).to(equal("6.72m"))
    }

    func test_decimalFormatter_withSign_shouldFormatDecimals() throws {
        expect(self.usFormatter.string(from: 123.456, sign: .none)).to(equal("123.46"))
        expect(self.usFormatter.string(from: 123.456, sign: .default)).to(equal("123.46"))
        expect(self.usFormatter.string(from: 123.456, sign: .both)).to(equal("+123.46"))
        expect(self.usFormatter.string(from: -123.456, sign: .none)).to(equal("123.46"))
        expect(self.usFormatter.string(from: -123.456, sign: .default)).to(equal("-123.46"))
        expect(self.usFormatter.string(from: -123.456, sign: .both)).to(equal("-123.46"))
    }

    func test_decimalFormatter_withArrowSign_shouldFormatDecimals() throws {
        expect(self.usFormatter.string(from: 123.456, sign: .arrow)).to(equal("▲123.46"))
        expect(self.usFormatter.string(from: -123.456, sign: .arrow)).to(equal("▼123.46"))
        expect(self.usFormatter.string(from: 123.456, sign: .spacedArrow)).to(equal("▲ 123.46"))
        expect(self.usFormatter.string(from: -123.456, sign: .spacedArrow)).to(equal("▼ 123.46"))
    }

    func test_decimalFormatter_withCustomSign_shouldFormatDecimals() throws {
        let plus: LocalizedFormatter.Sign.Style = .custom("▲")
        let minus: LocalizedFormatter.Sign.Style = .custom("▼")

        let plusOnly: LocalizedFormatter.Sign = .init(plus: plus, minus: .none)
        let minusOnly: LocalizedFormatter.Sign = .init(plus: .none, minus: minus)
        let both: LocalizedFormatter.Sign = .init(plus: plus, minus: minus)

        expect(self.usFormatter.string(from: 123.456, sign: plusOnly)).to(equal("▲123.46"))
        expect(self.usFormatter.string(from: -123.456, sign: plusOnly)).to(equal("123.46"))
        expect(self.usFormatter.string(from: 123.456, sign: minusOnly)).to(equal("123.46"))
        expect(self.usFormatter.string(from: -123.456, sign: minusOnly)).to(equal("▼123.46"))
        expect(self.usFormatter.string(from: 123.456, sign: both)).to(equal("▲123.46"))
        expect(self.usFormatter.string(from: -123.456, sign: both)).to(equal("▼123.46"))
    }

    func test_decimalFormatter_withSign_shouldFormatZero() throws {
        expect(self.usFormatter.string(from: 0, sign: .none)).to(equal("0"))
        expect(self.usFormatter.string(from: 0, sign: .default)).to(equal("0"))
        expect(self.usFormatter.string(from: 0, sign: .both)).to(equal("0"))
        expect(self.usFormatter.string(from: 0, sign: .arrow)).to(equal("0"))
        expect(self.usFormatter.string(from: 0.00, sign: .both)).to(equal("0"))
        expect(self.usFormatter.string(from: 0.001, sign: .both)).to(equal("0"))
        expect(self.usFormatter.string(from: -0, sign: .both)).to(equal("0"))
    }

    func test_decimalFormatter_usesSignForZero_shouldFormatZero() throws {
        let usFormatter = LocalizedFormatter.decimal(locale: Locale(identifier: "en_US")).apply {
            $0.usesSignForZero = true
        }
        let all: LocalizedFormatter.Sign = .init(plus: .custom("▲"), minus: .custom("▼"), zero: .custom("="))

        expect(usFormatter.string(from: 0, sign: .arrow)).to(equal("0"))
        expect(usFormatter.string(from: 0, sign: all)).to(equal("=0"))
        expect(usFormatter.string(from: 0.00, sign: all)).to(equal("=0"))
        expect(usFormatter.string(from: 0.001, sign: all)).to(equal("=0"))
        expect(usFormatter.string(from: -0, sign: .arrow)).to(equal("0"))
        expect(usFormatter.string(from: -0, sign: all)).to(equal("=0"))
        expect(usFormatter.string(from: -0.00, sign: all)).to(equal("=0"))
        expect(usFormatter.string(from: -0.001, sign: all)).to(equal("=0"))
    }

    func test_decimalFormatter_withPrecision_shouldFormatDecimals() throws {
        expect(self.usFormatter.string(from: 0.123456789, precision: .default)).to(equal("0.12"))
        expect(self.usFormatter.string(from: 0.123456789, precision: .maximum)).to(equal("0.123456789"))
        expect(self.usFormatter.string(from: 0.123456789, precision: .init())).to(equal("0.123456789"))
        expect(self.usFormatter.string(from: 0.12, precision: .init(3...))).to(equal("0.120"))
        expect(self.usFormatter.string(from: 0.123456789, precision: .init(3...))).to(equal("0.123456789"))
        expect(self.usFormatter.string(from: 0.1234, precision: .init(...5))).to(equal("0.1234"))
        expect(self.usFormatter.string(from: 0.123456789, precision: .init(...5))).to(equal("0.12346"))
        expect(self.usFormatter.string(from: 0.123456789, precision: .init(...9))).to(equal("0.123456789"))
        expect(self.usFormatter.string(from: 0.123456, precision: .init(3 ... 9))).to(equal("0.123456"))
        expect(self.usFormatter.string(from: 0.123456789, precision: .init(3 ... 9))).to(equal("0.123456789"))
        expect(self.usFormatter.string(from: 0.123456789, precision: .constant(4))).to(equal("0.1235"))
        expect(self.usFormatter.string(from: 0.123, precision: .constant(4))).to(equal("0.1230"))
    }

    func test_decimalFormatter_withAbbreviationAndSignAndPrecision_shouldFormatDecimals() throws {
        expect(self.usFormatter
            .string(from: -123.123456789, abbreviation: .default, sign: .arrow, precision: .constant(4)))
            .to(equal("▼123.1235"))
        expect(self.usFormatter
            .string(from: 123_456_789.123456789, abbreviation: .default, sign: .arrow, precision: .constant(4)))
            .to(equal("▲123.4568m"))
    }

    func test_decimalFormatter_shouldSetGroupingSeparator() throws {
        let usFormatter = LocalizedFormatter.decimal(locale: Locale(identifier: "en_US"))
        expect(usFormatter.string(from: 123_456)).to(equal("123,456"))

        usFormatter.usesGroupingSeparator = false
        expect(usFormatter.string(from: 123_456)).to(equal("123456"))
    }

    func test_decimalFormatter_shouldHaveCorrectDecimalSeparators() throws {
        let usFormatter = LocalizedFormatter.decimal(locale: Locale(identifier: "en_US"))
        expect(usFormatter.decimalSeparator).to(equal("."))

        let plFormatter = LocalizedFormatter.decimal(locale: Locale(identifier: "pl_PL"))
        expect(plFormatter.decimalSeparator).to(equal(","))
    }

    func test_decimalFormatter_shouldReadNumberFromString() throws {
        let usFormatter = LocalizedFormatter.decimal(locale: Locale(identifier: "en_US"))

        expect(usFormatter.number(from: "1")).to(equal(NSNumber(1)))
        expect(usFormatter.number(from: "-1")).to(equal(NSNumber(-1)))
        expect(usFormatter.number(from: "phantom-kit")).to(beNil())

        expect(usFormatter.number(from: "123.321")).to(equal(NSDecimalNumber(string: "123.321")))
        expect(usFormatter.decimalNumber(from: "123.321")).to(equal(NSDecimalNumber(string: "123.321")))
        expect(usFormatter.decimalNumber(from: "phantom-kit")).to(beNil())
    }
}
