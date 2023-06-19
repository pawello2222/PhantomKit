//
//  Equatable+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 19/06/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

import Foundation

extension Equatable {
    public func isContained(in array: [Self]) -> Bool {
        array.contains(self)
    }
}
