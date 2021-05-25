//
//  Numbers+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Comparable {
    public func clamped(to limits: PartialRangeFrom<Self>) -> Self {
        max(self, limits.lowerBound)
    }

    public func clamped(to limits: PartialRangeThrough<Self>) -> Self {
        min(self, limits.upperBound)
    }
}
