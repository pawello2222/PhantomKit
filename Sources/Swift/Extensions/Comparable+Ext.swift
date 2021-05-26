//
//  Comparable+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Comparable {
    public func clamped(to bounds: PartialRangeFrom<Self>) -> Self {
        max(self, bounds.lowerBound)
    }

    public func clamped(to bounds: PartialRangeThrough<Self>) -> Self {
        min(self, bounds.upperBound)
    }
}
