//
//  Set+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.04.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import Foundation

extension Set {
    /// Removes the element if it's present in the set
    /// or inserts it otherwise.
    public mutating func toggle(_ element: Element) {
        if contains(element) {
            remove(element)
        } else {
            insert(element)
        }
    }
}
