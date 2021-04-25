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
    public func present<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .button,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        modifier(PresentationModifier(method: .push(trigger: trigger), content: content))
    }

    public func present<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .button,
        content: @autoclosure @escaping () -> Content
    ) -> some View where Content: View {
        present(triggeredBy: trigger, content: content)
    }
}

// MARK: - Sheet

extension View {
    public func sheet<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .button,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        modifier(PresentationModifier(method: .sheet(trigger: trigger), content: content))
    }

    public func sheet<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .button,
        content: @autoclosure @escaping () -> Content
    ) -> some View where Content: View {
        sheet(triggeredBy: trigger, content: content)
    }
}

// MARK: - Full Screen

extension View {
    public func fullScreen<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .button,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        modifier(PresentationModifier(method: .fullScreen(trigger: trigger), content: content))
    }

    public func fullScreen<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .button,
        content: @autoclosure @escaping () -> Content
    ) -> some View where Content: View {
        fullScreen(triggeredBy: trigger, content: content)
    }
}
