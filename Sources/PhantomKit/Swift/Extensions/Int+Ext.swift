//
//  Int+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 30.10.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Int {
    public func times(_ block: () -> Void) {
        if self > 0 {
            for _ in 0 ..< self {
                block()
            }
        }
    }

    public func times(_ block: @autoclosure () -> Void) {
        if self > 0 {
            for _ in 0 ..< self {
                block()
            }
        }
    }
}
