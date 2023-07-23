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

class DecimalFormatterTests: XCTestCase {
    let usFormatter = LocalizedFormatter.decimal(locale: .init(identifier: "en_US"))

    func test_shouldFormatIntegers() throws {
        XCTAssertEqual(usFormatter.string(from: 1), "1")
        XCTAssertEqual(usFormatter.string(from: 432), "432")
        XCTAssertEqual(usFormatter.string(from: 1000), "1,000")
        XCTAssertEqual(usFormatter.string(from: 48_729_432), "48,729,432")
    }

    func test_withLocalePL_shouldFormatIntegers() throws {
        let plFormatter = LocalizedFormatter.decimal(locale: .init(identifier: "pl_PL"))

        XCTAssertEqual(plFormatter.string(from: 1), "1")
        XCTAssertEqual(plFormatter.string(from: 432), "432")
        XCTAssertEqual(plFormatter.string(from: 1000), "1000")
        XCTAssertEqual(plFormatter.string(from: 48_729_432), "48 729 432")
    }

    func test_shouldFormatNegativeIntegers() throws {
        XCTAssertEqual(usFormatter.string(from: -1), "-1")
        XCTAssertEqual(usFormatter.string(from: -432), "-432")
        XCTAssertEqual(usFormatter.string(from: -1000), "-1,000")
        XCTAssertEqual(usFormatter.string(from: -48_729_432), "-48,729,432")
    }

    func test_withAbbreviation_shouldFormatIntegers() throws {
        XCTAssertEqual(usFormatter.string(from: 1, abbreviation: .default), "1")
        XCTAssertEqual(usFormatter.string(from: 432, abbreviation: .default), "432")
        XCTAssertEqual(usFormatter.string(from: 1000, abbreviation: .default), "1k")
        XCTAssertEqual(usFormatter.string(from: 48_729_432, abbreviation: .default), "48.73m")
    }

    func test_withAbbreviationCapitalized_shouldFormatIntegers() throws {
        XCTAssertEqual(usFormatter.string(from: 1, abbreviation: .capitalized), "1")
        XCTAssertEqual(usFormatter.string(from: 432, abbreviation: .capitalized), "432")
        XCTAssertEqual(usFormatter.string(from: 1000, abbreviation: .capitalized), "1K")
        XCTAssertEqual(usFormatter.string(from: 48_729_432, abbreviation: .capitalized), "48.73M")
    }

    func test_shouldFormatDecimals() throws {
        XCTAssertEqual(usFormatter.string(from: 0.648723), "0.65")
        XCTAssertEqual(usFormatter.string(from: Float(0.648723)), "0.65")
        XCTAssertEqual(usFormatter.string(from: Decimal(0.648723)), "0.65")
        XCTAssertEqual(usFormatter.string(from: 12.53), "12.53")
        XCTAssertEqual(usFormatter.string(from: 123.000), "123")
        XCTAssertEqual(usFormatter.string(from: 6_723_846.5673658), "6,723,846.57")
    }

    func test_withLocalePL_shouldFormatDecimals() throws {
        let plFormatter = LocalizedFormatter.decimal(locale: .init(identifier: "pl_PL"))

        XCTAssertEqual(plFormatter.string(from: 0.648723), "0,65")
        XCTAssertEqual(plFormatter.string(from: 12.53), "12,53")
        XCTAssertEqual(plFormatter.string(from: 123.000), "123")
        XCTAssertEqual(plFormatter.string(from: 6_723_846.5673658), "6 723 846,57")
    }

    func test_withAbbreviation_shouldFormatDecimals() throws {
        XCTAssertEqual(usFormatter.string(from: 0.648723, abbreviation: .default), "0.65")
        XCTAssertEqual(usFormatter.string(from: 12.53, abbreviation: .default), "12.53")
        XCTAssertEqual(usFormatter.string(from: 123_000.01, abbreviation: .default), "123k")
        XCTAssertEqual(usFormatter.string(from: 6_723_846.5673658, abbreviation: .default), "6.72m")
    }

    func test_withSign_shouldFormatDecimals() throws {
        XCTAssertEqual(usFormatter.string(from: 123.456, sign: .none), "123.46")
        XCTAssertEqual(usFormatter.string(from: 123.456, sign: .default), "123.46")
        XCTAssertEqual(usFormatter.string(from: 123.456, sign: .both), "+123.46")
        XCTAssertEqual(usFormatter.string(from: -123.456, sign: .none), "123.46")
        XCTAssertEqual(usFormatter.string(from: -123.456, sign: .default), "-123.46")
        XCTAssertEqual(usFormatter.string(from: -123.456, sign: .both), "-123.46")
    }

    func test_withArrowSign_shouldFormatDecimals() throws {
        XCTAssertEqual(usFormatter.string(from: 123.456, sign: .arrow), "▲123.46")
        XCTAssertEqual(usFormatter.string(from: -123.456, sign: .arrow), "▼123.46")
        XCTAssertEqual(usFormatter.string(from: 123.456, sign: .spacedArrow), "▲ 123.46")
        XCTAssertEqual(usFormatter.string(from: -123.456, sign: .spacedArrow), "▼ 123.46")
    }

    func test_withCustomSign_shouldFormatDecimals() throws {
        let plus: LocalizedFormatter.Sign.Style = .custom("▲")
        let minus: LocalizedFormatter.Sign.Style = .custom("▼")

        let plusOnly: LocalizedFormatter.Sign = .init(plus: plus, minus: .none)
        let minusOnly: LocalizedFormatter.Sign = .init(plus: .none, minus: minus)
        let both: LocalizedFormatter.Sign = .init(plus: plus, minus: minus)

        XCTAssertEqual(usFormatter.string(from: 123.456, sign: plusOnly), "▲123.46")
        XCTAssertEqual(usFormatter.string(from: -123.456, sign: plusOnly), "123.46")
        XCTAssertEqual(usFormatter.string(from: 123.456, sign: minusOnly), "123.46")
        XCTAssertEqual(usFormatter.string(from: -123.456, sign: minusOnly), "▼123.46")
        XCTAssertEqual(usFormatter.string(from: 123.456, sign: both), "▲123.46")
        XCTAssertEqual(usFormatter.string(from: -123.456, sign: both), "▼123.46")
    }

    func test_withSign_shouldFormatZero() throws {
        XCTAssertEqual(usFormatter.string(from: 0, sign: .none), "0")
        XCTAssertEqual(usFormatter.string(from: 0, sign: .default), "0")
        XCTAssertEqual(usFormatter.string(from: 0, sign: .both), "0")
        XCTAssertEqual(usFormatter.string(from: 0, sign: .arrow), "0")
        XCTAssertEqual(usFormatter.string(from: 0.00, sign: .both), "0")
        XCTAssertEqual(usFormatter.string(from: 0.001, sign: .both), "0")
        XCTAssertEqual(usFormatter.string(from: -0, sign: .both), "0")
    }

    func test_usesSignForZero_shouldFormatZero() throws {
        let usFormatter = LocalizedFormatter.decimal(locale: Locale(identifier: "en_US")).apply {
            $0.usesSignForZero = true
        }
        let all: LocalizedFormatter.Sign = .init(plus: .custom("▲"), minus: .custom("▼"), zero: .custom("="))

        XCTAssertEqual(usFormatter.string(from: 0, sign: .arrow), "0")
        XCTAssertEqual(usFormatter.string(from: 0, sign: all), "=0")
        XCTAssertEqual(usFormatter.string(from: 0.00, sign: all), "=0")
        XCTAssertEqual(usFormatter.string(from: 0.001, sign: all), "=0")
        XCTAssertEqual(usFormatter.string(from: -0, sign: .arrow), "0")
        XCTAssertEqual(usFormatter.string(from: -0, sign: all), "=0")
        XCTAssertEqual(usFormatter.string(from: -0.00, sign: all), "=0")
        XCTAssertEqual(usFormatter.string(from: -0.001, sign: all), "=0")
    }

    func test_withPrecision_shouldFormatDecimals() throws {
        XCTAssertEqual(usFormatter.string(from: 0.123456789, precision: .default), "0.12")
        XCTAssertEqual(usFormatter.string(from: 0.123456789, precision: .maximum), "0.123456789")
        XCTAssertEqual(usFormatter.string(from: 0.123456789, precision: .init()), "0.123456789")
        XCTAssertEqual(usFormatter.string(from: 0.12, precision: .init(3...)), "0.120")
        XCTAssertEqual(usFormatter.string(from: 0.123456789, precision: .init(3...)), "0.123456789")
        XCTAssertEqual(usFormatter.string(from: 0.1234, precision: .init(...5)), "0.1234")
        XCTAssertEqual(usFormatter.string(from: 0.123456789, precision: .init(...5)), "0.12346")
        XCTAssertEqual(usFormatter.string(from: 0.123456789, precision: .init(...9)), "0.123456789")
        XCTAssertEqual(usFormatter.string(from: 0.123456, precision: .init(3 ... 9)), "0.123456")
        XCTAssertEqual(usFormatter.string(from: 0.123456789, precision: .init(3 ... 9)), "0.123456789")
        XCTAssertEqual(usFormatter.string(from: 0.123456789, precision: .constant(4)), "0.1235")
        XCTAssertEqual(usFormatter.string(from: 0.123, precision: .constant(4)), "0.1230")
    }

    func test_withAbbreviationAndSignAndPrecision_shouldFormatDecimals() throws {
        XCTAssertEqual(
            usFormatter.string(
                from: -123.123456789,
                abbreviation: .default,
                sign: .arrow,
                precision: .constant(4)
            ),
            "▼123.1235"
        )
        XCTAssertEqual(
            usFormatter.string(
                from: 123_456_789.123456789,
                abbreviation: .default,
                sign: .arrow,
                precision: .constant(4)
            ),
            "▲123.4568m"
        )
    }

    func test_shouldSetGroupingSeparator() throws {
        let usFormatter = LocalizedFormatter.decimal(locale: Locale(identifier: "en_US"))
        XCTAssertEqual(usFormatter.string(from: 123_456), "123,456")

        usFormatter.usesGroupingSeparator = false
        XCTAssertEqual(usFormatter.string(from: 123_456), "123456")
    }

    func test_shouldHaveCorrectDecimalSeparators() throws {
        let usFormatter = LocalizedFormatter.decimal(locale: Locale(identifier: "en_US"))
        XCTAssertEqual(usFormatter.decimalSeparator, ".")

        let plFormatter = LocalizedFormatter.decimal(locale: Locale(identifier: "pl_PL"))
        XCTAssertEqual(plFormatter.decimalSeparator, ",")
    }

    func test_shouldReadNumberFromString() throws {
        let usFormatter = LocalizedFormatter.decimal(locale: Locale(identifier: "en_US"))

        XCTAssertEqual(usFormatter.number(from: "1"), NSNumber(1))
        XCTAssertEqual(usFormatter.number(from: "-1"), NSNumber(-1))
        XCTAssertNil(usFormatter.number(from: "phantom-kit"))

        XCTAssertEqual(usFormatter.number(from: "123.321"), NSDecimalNumber(string: "123.321"))
        XCTAssertEqual(usFormatter.decimalNumber(from: "123.321"), NSDecimalNumber(string: "123.321"))
        XCTAssertNil(usFormatter.decimalNumber(from: "PhantomKit"))
    }
}
