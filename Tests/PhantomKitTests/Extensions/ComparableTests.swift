//
//  ComparableTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import XCTest
@testable import PhantomKit

class ComparableTests: XCTestCase {
    func test_comparable_shouldClampToBounds() throws {
        XCTAssertEqual(1.clamped(to: 0...), 1)
        XCTAssertEqual(1.clamped(to: 1...), 1)
        XCTAssertEqual(1.clamped(to: 2...), 2)
        XCTAssertEqual(1.clamped(to: ...0), 0)
        XCTAssertEqual(1.clamped(to: ...1), 1)
        XCTAssertEqual(1.clamped(to: ...2), 1)
        XCTAssertEqual(1.clamped(to: 0 ... 2), 1)
        XCTAssertEqual(1.clamped(to: 2 ... 3), 2)
        XCTAssertEqual(1.clamped(to: -1 ... 0), 0)
        XCTAssertEqual(1.clamped(to: 1 ... 1), 1)
    }
}
