//
//  View+Action.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 29.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// MARK: - Action

extension View {
    @ViewBuilder
    public func action(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        _ action: @escaping () -> Void
    ) -> some View {
        switch trigger {
        case .tap:
            onTapGesture(perform: action)
        case .button(let style):
            Button(action: action) {
                self.contentShape(Rectangle())
            }
            .buttonStyle(style)
        case .primitiveButton(let style):
            Button(action: action) {
                self.contentShape(Rectangle())
            }
            .buttonStyle(style)
        }
    }

    public func action(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        _ action: @autoclosure @escaping () -> Void
    ) -> some View {
        self.action(triggeredBy: trigger, action)
    }

    @ViewBuilder
    public func action(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        _ action: (() -> Void)?
    ) -> some View {
        if let action = action {
            self.action(triggeredBy: trigger, action)
        }
    }
}

// MARK: - Animated Action

extension View {
    public func animatedAction(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        _ action: @autoclosure @escaping () -> Void
    ) -> some View {
        animatedAction(triggeredBy: trigger, action)
    }

    @ViewBuilder
    public func animatedAction(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        _ action: (() -> Void)?
    ) -> some View {
        if let action = action {
            self.action(triggeredBy: trigger) {
                withAnimation {
                    action()
                }
            }
        }
    }
}
