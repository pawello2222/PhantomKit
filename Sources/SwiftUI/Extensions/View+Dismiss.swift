//
//  View+Dismiss.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 24/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

private struct DismissActionWrapper: Equatable {
    let id = UUID()
    let action: (UIViewController.DismissMethod) -> Void

    func callAsFunction(_ method: UIViewController.DismissMethod) {
        action(method)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

private struct DismissActionPreferenceKey: PreferenceKey {
    static var defaultValue: DismissActionWrapper?

    static func reduce(value: inout DismissActionWrapper?, nextValue: () -> DismissActionWrapper?) {
        value.merge(nextValue())
    }
}

extension View {
    public typealias DismissMethod = UIViewController.DismissMethod

    public func onDismiss(perform action: @escaping (DismissMethod) -> Void) -> some View {
        transformPreference(DismissActionPreferenceKey.self) { value in
            value.merge(.init(action: action))
        }
    }
}

extension Optional where Wrapped == DismissActionWrapper {
    fileprivate mutating func merge(_ other: Wrapped?) {
        switch (self, other) {
        case (.some(let lhs), .some(let rhs)):
            guard lhs != rhs else { break }

            self = DismissActionWrapper { method in
                lhs.action(method)
                rhs.action(method)
            }
        case (.none, .some(let rhs)):
            self = rhs
        case (_, .none):
            break
        }
    }
}
