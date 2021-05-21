//
//  PresentationModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct PresentationModifier<Destination>: ViewModifier where Destination: View {
    @Environment(\.appTheme) private var theme
    private let method: PresentationMethod
    private let onTrigger: (() -> Void)?
    private let onDismiss: (() -> Void)?
    private let content: () -> Destination

    @State private var isActive = false

    public init(
        method: PresentationMethod = .link,
        onTrigger: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Destination
    ) {
        self.method = method
        self.onTrigger = onTrigger
        self.onDismiss = onDismiss
        self.content = content
    }

    @ViewBuilder
    public func body(content: Content) -> some View {
        transitionBody(
            content
                .modifier(PresentationTriggerModifier(trigger: method.trigger, isActive: $isActive, onTrigger: onTrigger))
        )
    }
}

// MARK: - Transition Body

extension PresentationModifier {
    @ViewBuilder
    private func transitionBody<Content>(_ content: Content) -> some View where Content: View {
        switch method.transition {
        case .link:
            content
                .background(NavigationLink("", destination: destination(), isActive: $isActive).hidden())
        case .sheet:
            content
                .sheet(isPresented: $isActive, onDismiss: onDismiss, content: destination)
        case .fullScreen:
            content
                .fullScreenCover(isPresented: $isActive, onDismiss: onDismiss, content: destination)
        }
    }

    @ViewBuilder
    private func destination() -> some View {
        content()
            .rootViewAppearance(theme: theme)
    }
}
