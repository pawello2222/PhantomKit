//
//  View+Presentation.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// MARK: - Push

extension View {
    public func link<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder destination: @escaping () -> Content
    ) -> some View where Content: View {
        modifier(PresentationModifier(method: .push(trigger: trigger), onDismiss: onDismiss, content: destination))
    }

    public func link<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        onDismiss: (() -> Void)? = nil,
        destination: @autoclosure @escaping () -> Content
    ) -> some View where Content: View {
        link(triggeredBy: trigger, onDismiss: onDismiss, destination: destination)
    }
}

// MARK: - Sheet

extension View {
    public func sheet<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        modifier(PresentationModifier(method: .sheet(trigger: trigger), onDismiss: onDismiss, content: content))
    }

    public func sheet<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        onDismiss: (() -> Void)? = nil,
        content: @autoclosure @escaping () -> Content
    ) -> some View where Content: View {
        sheet(triggeredBy: trigger, onDismiss: onDismiss, content: content)
    }
}

// MARK: - Full Screen

extension View {
    public func fullScreen<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        modifier(PresentationModifier(method: .fullScreen(trigger: trigger), onDismiss: onDismiss, content: content))
    }

    public func fullScreen<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        onDismiss: (() -> Void)? = nil,
        content: @autoclosure @escaping () -> Content
    ) -> some View where Content: View {
        fullScreen(triggeredBy: trigger, onDismiss: onDismiss, content: content)
    }
}

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
        self.animatedAction(triggeredBy: trigger, action)
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
