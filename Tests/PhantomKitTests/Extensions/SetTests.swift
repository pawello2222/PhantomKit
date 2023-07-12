//
//  SetTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import XCTest
@testable import PhantomKit

class SetTests: XCTestCase {
    func test_set_toggleExistingElement_shouldRemoveElement() throws {
        var set = Set([1, 2, 3])

        set.toggle(3)

        XCTAssertTrue(set.contains(1))
        XCTAssertTrue(set.contains(2))
        XCTAssertFalse(set.contains(3))
        XCTAssertFalse(set.contains(4))
    }

    func test_set_toggleNonExistingElement_shouldAddElement() throws {
        var set = Set([1, 2, 3])

        set.toggle(4)

        XCTAssertTrue(set.contains(1))
        XCTAssertTrue(set.contains(2))
        XCTAssertTrue(set.contains(3))
        XCTAssertTrue(set.contains(4))
        XCTAssertFalse(set.contains(5))
    }
}
