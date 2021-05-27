//
//  PercentFormatterTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 09.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Nimble
import XCTest
@testable import PhantomKit

class PercentFormatterTests: XCTestCase {
    let usFormatter = LocalizedFormatter.makePercentFormatter(locale: .init(identifier: "en_US"))

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_percentFormatter_shouldFormatPercent() throws {
        expect(self.usFormatter.string(from: 0.032)).to(equal("0.03%"))
        expect(self.usFormatter.string(from: 23)).to(equal("23%"))
        expect(self.usFormatter.string(from: 122.54)).to(equal("122.54%"))
    }
}
