//
//  TimeInterval+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 28/06/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

import Foundation

extension TimeInterval {
    /// The duration of `0.1` seconds.
    public static var ultraFast: Self = 0.1

    /// The duration of `0.2` seconds.
    public static var fast: Self = 0.2

    /// The duration of `0.3` seconds.
    public static var `default`: Self = 0.3

    /// The duration of `0.6` seconds.
    public static var slow: Self = 0.6

    /// The duration of `1.0` seconds.
    public static var ultraSlow: Self = 1.0
}
