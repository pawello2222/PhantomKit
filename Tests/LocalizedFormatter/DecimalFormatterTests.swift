//
//  DecimalFormatterTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 09.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Nimble
import XCTest
@testable import PhantomKit

class DecimalFormatterTests: XCTestCase {
    let usFormatter = LocalizedFormatter.makeDecimalFormatter(locale: .init(identifier: "en_US"))

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_decimalFormatter_shouldFormatIntegers() throws {
        expect(self.usFormatter.string(from: 1)).to(equal("1"))
        expect(self.usFormatter.string(from: 432)).to(equal("432"))
        expect(self.usFormatter.string(from: 1000)).to(equal("1,000"))
        expect(self.usFormatter.string(from: 48_729_432)).to(equal("48,729,432"))
    }

    func test_decimalFormatter_withLocalePL_shouldFormatIntegers() throws {
        let plFormatter = LocalizedFormatter.makeDecimalFormatter(locale: .init(identifier: "pl_PL"))

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
        expect(self.usFormatter.string(from: 1, abbreviated: true)).to(equal("1"))
        expect(self.usFormatter.string(from: 432, abbreviated: true)).to(equal("432"))
        expect(self.usFormatter.string(from: 1000, abbreviated: true)).to(equal("1k"))
        expect(self.usFormatter.string(from: 48_729_432, abbreviated: true)).to(equal("48.73m"))
    }

    func test_decimalFormatter_shouldFormatDecimals() throws {
        expect(self.usFormatter.string(from: 0.648723)).to(equal("0.65"))
        expect(self.usFormatter.string(from: 12.53)).to(equal("12.53"))
        expect(self.usFormatter.string(from: 123.000)).to(equal("123"))
        expect(self.usFormatter.string(from: 6_723_846.5673658)).to(equal("6,723,846.57"))
    }

    func test_decimalFormatter_withLocalePL_shouldFormatDecimals() throws {
        let plFormatter = LocalizedFormatter.makeDecimalFormatter(locale: .init(identifier: "pl_PL"))

        expect(plFormatter.string(from: 0.648723)).to(equal("0,65"))
        expect(plFormatter.string(from: 12.53)).to(equal("12,53"))
        expect(plFormatter.string(from: 123.000)).to(equal("123"))
        expect(plFormatter.string(from: 6_723_846.5673658)).to(equal("6 723 846,57"))
    }

    func test_decimalFormatter_withAbbreviation_shouldFormatDecimals() throws {
        expect(self.usFormatter.string(from: 0.648723, abbreviated: true)).to(equal("0.65"))
        expect(self.usFormatter.string(from: 12.53, abbreviated: true)).to(equal("12.53"))
        expect(self.usFormatter.string(from: 123_000.01, abbreviated: true)).to(equal("123k"))
        expect(self.usFormatter.string(from: 6_723_846.5673658, abbreviated: true)).to(equal("6.72m"))
    }
}
