//
//  PresentationModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct PresentationModifier<DestinationContent>: ViewModifier where DestinationContent: View {
    @Environment(\.theme) private var theme
    private let method: PresentationMethod
    private let onDismiss: (() -> Void)?
    private let content: () -> DestinationContent

    @State private var isActive = false

    public init(
        method: PresentationMethod = .push,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> DestinationContent
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

// MARK: - Destination

extension PresentationModifier {
    @ViewBuilder
    private func destinationContent() -> some View {
        content()
            .themed(theme)
    }
}

// MARK: - Transition

extension PresentationModifier {
    @ViewBuilder
    private func transitionBody<Content>(_ content: Content) -> some View where Content: View {
        switch method.transition {
        case .push:
            content
                .background(NavigationLink("", destination: destinationContent(), isActive: $isActive))
        case .sheet:
            content
                .sheet(isPresented: $isActive, onDismiss: onDismiss, content: destinationContent)
        case .fullScreen:
            content
                .fullScreenCover(isPresented: $isActive, onDismiss: onDismiss, content: destinationContent)
        }
    }
}

// MARK: - Trigger

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
