//
//  SetTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Nimble
import XCTest
@testable import PhantomKit

class SetTests: XCTestCase {
    func test_set_toggleExistingElement_shouldRemoveElement() throws {
        var set = Set([1, 2, 3])

        set.toggle(3)

        expect(set.contains(1)).to(beTrue())
        expect(set.contains(2)).to(beTrue())
        expect(set.contains(3)).to(beFalse())
        expect(set.contains(4)).to(beFalse())
    }

    func test_set_toggleNonExistingElement_shouldAddElement() throws {
        var set = Set([1, 2, 3])

        set.toggle(4)

        expect(set.contains(1)).to(beTrue())
        expect(set.contains(2)).to(beTrue())
        expect(set.contains(3)).to(beTrue())
        expect(set.contains(4)).to(beTrue())
        expect(set.contains(5)).to(beFalse())
    }
}
