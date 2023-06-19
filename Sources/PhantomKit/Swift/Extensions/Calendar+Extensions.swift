//
//  Calendar+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 19/06/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

import Foundation

extension Calendar {
    /// Returns `ISO` calendar with `en_US_POSIX` locale and `UTC` time zone.
    public static let iso = Self(
        identifier: .gregorian
    ).applying {
        $0.timeZone = .utc
        $0.locale = .usPosix
    }
}
