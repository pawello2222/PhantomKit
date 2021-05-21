//
//  Binding+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension Binding {
    public func onSet(_ action: @escaping (Value) -> Void) -> Self {
        .init(
            get: {
                wrappedValue
            },
            set: {
                wrappedValue = $0
                action(wrappedValue)
            }
        )
    }
}

// MARK: - Operators

public func ?? <T>(lhs: Binding<T?>, rhs: T) -> Binding<T> {
    .init(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
