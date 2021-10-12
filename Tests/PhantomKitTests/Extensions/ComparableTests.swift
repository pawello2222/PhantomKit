//
//  ComparableTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Nimble
import XCTest
@testable import PhantomKit

class ComparableTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_comparable_shouldClampToBounds() throws {
        expect(1.clamped(to: 0...)).to(equal(1))
        expect(1.clamped(to: 1...)).to(equal(1))
        expect(1.clamped(to: 2...)).to(equal(2))
        expect(1.clamped(to: ...0)).to(equal(0))
        expect(1.clamped(to: ...1)).to(equal(1))
        expect(1.clamped(to: ...2)).to(equal(1))
        expect(1.clamped(to: 0 ... 2)).to(equal(1))
        expect(1.clamped(to: 2 ... 3)).to(equal(2))
        expect(1.clamped(to: -1 ... 0)).to(equal(0))
        expect(1.clamped(to: 1 ... 1)).to(equal(1))
    }
}
