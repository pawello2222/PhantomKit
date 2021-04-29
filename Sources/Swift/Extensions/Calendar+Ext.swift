//
//  Calendar+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 22/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Calendar {
    public var year: Int? {
        dateComponents([.year], from: Date()).year
    }

    public var month: Int? {
        dateComponents([.month], from: Date()).month
    }

    public var day: Int? {
        dateComponents([.day], from: Date()).day
    }
}
