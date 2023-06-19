//
//  Binding+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import SwiftUI

// MARK: - Operators

public func ?? <T>(lhs: Binding<T?>, rhs: T) -> Binding<T> {
    .init(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
