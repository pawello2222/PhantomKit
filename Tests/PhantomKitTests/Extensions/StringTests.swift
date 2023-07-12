//
//  StringTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import XCTest
@testable import PhantomKit

class StringTests: XCTestCase {
    func test_string_isHexNumber_shouldRecognizeHexNumbers() throws {
        XCTAssertTrue("123".isHexNumber)
        XCTAssertTrue("aa32".isHexNumber)
        XCTAssertTrue("AD1".isHexNumber)
        XCTAssertFalse("FFG".isHexNumber)
        XCTAssertFalse("text1".isHexNumber)
    }
}
