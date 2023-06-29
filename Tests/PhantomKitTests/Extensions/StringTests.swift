//
//  StringTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import Nimble
import XCTest
@testable import PhantomKit

class StringTests: XCTestCase {
    func test_string_isHexNumber_shouldRecognizeHexNumbers() throws {
        expect("123".isHexNumber).to(beTrue())
        expect("aa32".isHexNumber).to(beTrue())
        expect("AD1".isHexNumber).to(beTrue())
        expect("FFG".isHexNumber).to(beFalse())
        expect("text1".isHexNumber).to(beFalse())
    }
}
