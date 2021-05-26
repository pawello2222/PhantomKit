//
//  ArrayTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Nimble
import XCTest
@testable import PhantomKit

class ArrayTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_array_keyPaths_shouldWorkForEquatableElements() throws {
        var array = [3, 1, 2, 3, 1]

        expect(array.firstIndex(where: \.self, equals: 1)).to(equal(1))
        expect(array.first(where: \.self, equals: 1)).to(equal(1))
        expect(array.filter(where: \.self, equals: 1)).to(equal([1, 1]))
        expect(array.filter(where: \.self, notEquals: 1)).to(equal([3, 2, 3]))

        array.removeFirst(where: \.self, equals: 2)
        expect(array).to(equal([3, 1, 3, 1]))
    }

    func test_array_toggleExistingElement_shouldRemoveElement() throws {
        var array = [1, 2, 3]

        array.toggle(3)
        expect(array.contains(1)).to(beTrue())
        expect(array.contains(2)).to(beTrue())
        expect(array.contains(3)).to(beFalse())
        expect(array.contains(4)).to(beFalse())
    }

    func test_array_toggleNonExistingElement_shouldAddElement() throws {
        var array = [1, 2, 3]

        array.toggle(4)
        expect(array.contains(1)).to(beTrue())
        expect(array.contains(2)).to(beTrue())
        expect(array.contains(3)).to(beTrue())
        expect(array.contains(4)).to(beTrue())
        expect(array.contains(5)).to(beFalse())
    }

    func test_array_safeIndexSubscript_shouldNotThrowError() throws {
        let array = [1, 2, 3]

        expect(array[safe: 0]).to(equal(1))
        expect(array[safe: 2]).to(equal(3))
        expect(array[safe: 3]).to(beNil())
        expect(array[safe: -1]).to(beNil())
        expect(array[safe: 100]).to(beNil())
        expect(array[safe: -100]).to(beNil())
    }

    func test_array_safeRangeSubscript_shouldNotThrowError() throws {
        let array = [1, 2, 3]

        expect(array[safe: 0 ..< 1]).to(equal([1]))
        expect(array[safe: 0 ..< 3]).to(equal([1, 2, 3]))
        expect(array[safe: -1 ..< 5]).to(equal([1, 2, 3]))
        expect(array[safe: 2 ..< 100]).to(equal([3]))
        expect(array[safe: -100 ..< 1]).to(equal([1]))
        expect(array[safe: -100 ..< 0]).to(equal([]))
        expect(array[safe: 3 ..< 100]).to(equal([]))
    }
}
