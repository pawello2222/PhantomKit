//
//  Array+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable & Hashable {
    public mutating func toggle(_ item: Element) {
        if let index = firstIndex(where: { $0.id == item.id }) {
            remove(at: index)
        } else {
            append(item)
        }
    }
}
