//
//  AlertModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct AlertModifier: ViewModifier {
    private let trigger: PresentationMethod.Trigger
    private let content: () -> Alert

    @State private var isActive = false

    public init(
        trigger: PresentationMethod.Trigger = .default,
        @ViewBuilder content: @escaping () -> Alert
    ) {
        self.trigger = trigger
        self.content = content
    }

    @ViewBuilder
    public func body(content: Content) -> some View {
        content
            .modifier(PresentationTriggerModifier(trigger: trigger, isActive: $isActive))
            .alert(isPresented: $isActive, content: self.content)
    }
}

// MARK: - View

extension View {
    public func alert(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        @ViewBuilder content: @escaping () -> Alert
    ) -> some View {
        modifier(AlertModifier(trigger: trigger, content: content))
    }

    public func alert(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        content: @autoclosure @escaping () -> Alert
    ) -> some View {
        alert(content: content)
    }
}
