//
//  PercentFormatterTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 09.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import XCTest
@testable import PhantomKit

class PercentFormatterTests: XCTestCase {
    private let usFormatter = LocalizedFormatter.percent(locale: .init(identifier: "en_US"))

    func test_percentFormatter_shouldFormatPercent() throws {
        XCTAssertEqual(usFormatter.string(from: 0.032), "0.03%")
        XCTAssertEqual(usFormatter.string(from: 23), "23%")
        XCTAssertEqual(usFormatter.string(from: 122.54), "122.54%")
    }
}
