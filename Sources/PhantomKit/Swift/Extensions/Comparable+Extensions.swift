//
//  Comparable+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 19/06/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

import Foundation

extension Comparable {
    /// Returns a copy of `self` clamped to the given limiting range.
    public func clamped(to bounds: ClosedRange<Self>) -> Self {
        min(max(self, bounds.lowerBound), bounds.upperBound)
    }

    /// Returns a copy of `self` clamped to the given limiting range.
    public func clamped(to bounds: PartialRangeFrom<Self>) -> Self {
        max(self, bounds.lowerBound)
    }

    /// Returns a copy of `self` clamped to the given limiting range.
    public func clamped(to bounds: PartialRangeThrough<Self>) -> Self {
        min(self, bounds.upperBound)
    }
}
