//
//  RefreshGuardianTests.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 12.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Nimble
import XCTest
@testable import PhantomKit

extension RefreshGuardian {
    fileprivate static let test: Key = .init(name: "test", interval: (1, .day))
}

class RefreshGuardianTests: XCTestCase {
    let currentDate = Date(year: 2001, month: 6, day: 6, hour: 6, minute: 6, second: 6, calendar: .default)

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_refreshGuardian_shouldAllowUpdatesForNilDate() throws {
        RefreshGuardian.test.lastUpdated = nil
        expect(RefreshGuardian.test.canUpdate(for: self.currentDate)).to(beTrue())
    }

    func test_refreshGuardian_shouldPreventUpdatesForCurrentDate() throws {
        RefreshGuardian.test.lastUpdated = currentDate
        expect(RefreshGuardian.test.canUpdate(for: self.currentDate)).to(beFalse())
    }

    func test_refreshGuardian_shouldAllowUpdatesForValidPastDate() throws {
        RefreshGuardian.test.lastUpdated = currentDate.adjusting(.day, by: -1)
        expect(RefreshGuardian.test.canUpdate(for: self.currentDate)).to(beTrue())

        RefreshGuardian.test.lastUpdated = currentDate
            .adjusting(.hour, by: -6)
            .adjusting(.minute, by: -6)
            .adjusting(.second, by: -7)
        expect(RefreshGuardian.test.canUpdate(for: self.currentDate)).to(beTrue())

        RefreshGuardian.test.lastUpdated = currentDate.adjusting(.hour, by: -7)
        expect(RefreshGuardian.test.canUpdate(for: self.currentDate)).to(beTrue())
    }

    func test_refreshGuardian_withIntervalOneDay_shouldPreventUpdatesForInvalidPastDate() throws {
        RefreshGuardian.test.lastUpdated = currentDate
        expect(RefreshGuardian.test.canUpdate(for: self.currentDate)).to(beFalse())

        RefreshGuardian.test.lastUpdated = currentDate.adjusting(.second, by: -1)
        expect(RefreshGuardian.test.canUpdate(for: self.currentDate)).to(beFalse())

        RefreshGuardian.test.lastUpdated = currentDate.adjusting(.minute, by: -1)
        expect(RefreshGuardian.test.canUpdate(for: self.currentDate)).to(beFalse())

        RefreshGuardian.test.lastUpdated = currentDate.adjusting(.hour, by: -6)
        expect(RefreshGuardian.test.canUpdate(for: self.currentDate)).to(beFalse())

        RefreshGuardian.test.lastUpdated = currentDate
            .adjusting(.hour, by: -6)
            .adjusting(.minute, by: -6)
            .adjusting(.second, by: -6)
        expect(RefreshGuardian.test.canUpdate(for: self.currentDate)).to(beFalse())
    }

    func test_refreshGuardian_withIntervalOneDay_shouldPreventUpdatesForFutureDate() throws {
        RefreshGuardian.test.lastUpdated = currentDate.adjusting(.second, by: 1)
        expect(RefreshGuardian.test.canUpdate(for: self.currentDate)).to(beFalse())

        RefreshGuardian.test.lastUpdated = currentDate.adjusting(.minute, by: 1)
        expect(RefreshGuardian.test.canUpdate(for: self.currentDate)).to(beFalse())

        RefreshGuardian.test.lastUpdated = currentDate.adjusting(.day, by: 1)
        expect(RefreshGuardian.test.canUpdate(for: self.currentDate)).to(beFalse())

        RefreshGuardian.test.lastUpdated = currentDate.adjusting(.year, by: 1)
        expect(RefreshGuardian.test.canUpdate(for: self.currentDate)).to(beFalse())
    }
}
