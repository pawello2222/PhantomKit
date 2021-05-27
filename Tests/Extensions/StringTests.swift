//
//  StringTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Nimble
import XCTest
@testable import PhantomKit

class StringTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_string_inParentheses_shouldAddParentheses() throws {
        expect("123".inParentheses()).to(equal("(123)"))
        expect("()".inParentheses()).to(equal("(())"))
        expect("".inParentheses()).to(equal("()"))
    }

    func test_string_isHexNumber_shouldRecognizeHexNumbers() throws {
        expect("123".isHexNumber).to(beTrue())
        expect("aa32".isHexNumber).to(beTrue())
        expect("AD1".isHexNumber).to(beTrue())
        expect("FFG".isHexNumber).to(beFalse())
        expect("text1".isHexNumber).to(beFalse())
    }
}
