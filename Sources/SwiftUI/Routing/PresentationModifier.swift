//
//  PresentationModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct PresentationModifier<Destination>: ViewModifier where Destination: View {
    @Environment(\.theme) private var theme
    private let method: PresentationMethod
    private let onDismiss: (() -> Void)?
    private let content: () -> Destination

    @State private var isActive = false

    public init(
        method: PresentationMethod = .push,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Destination
    ) {
        self.method = method
        self.onDismiss = onDismiss
        self.content = content
    }

    @ViewBuilder
    public func body(content: Content) -> some View {
        transitionBody(triggerBody(content))
    }
}

// MARK: - Transition Body

extension PresentationModifier {
    @ViewBuilder
    private func transitionBody<Content>(_ content: Content) -> some View where Content: View {
        switch method.transition {
        case .push:
            content
                .background(NavigationLink("", destination: destination(), isActive: $isActive))
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
            .themed(theme)
    }
}

// MARK: - Trigger Body

extension PresentationModifier {
    @ViewBuilder
    private func triggerBody(_ content: Content) -> some View {
        switch method.trigger {
        case .tap:
            content
                .onTapGesture {
                    isActive = true
                }
        case .button(let style):
            buttonBody(content)
                .buttonStyle(style)
        case .primitiveButton(let style):
            buttonBody(content)
                .buttonStyle(style)
        }
    }

    private func buttonBody(_ content: Content) -> some View {
        Button {
            isActive = true
        } label: {
            content
                .contentShape(Rectangle())
        }
    }
}
