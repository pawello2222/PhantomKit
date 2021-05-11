//
//  Equatable+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Equatable {
    public func isContained(in array: [Self]) -> Bool {
        array.contains(self)
    }
}
