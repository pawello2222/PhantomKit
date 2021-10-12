//
//  Set+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Set {
    public mutating func toggle(_ item: Element) {
        if contains(item) {
            remove(item)
        } else {
            insert(item)
        }
    }
}
