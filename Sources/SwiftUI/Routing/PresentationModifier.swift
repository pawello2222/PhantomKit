//
//  PresentationModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct PresentationModifier<DestinationContent>: ViewModifier where DestinationContent: View {
    private let method: PresentationMethod
    private let content: () -> DestinationContent

    @State private var isActive = false

    public init(method: PresentationMethod = .push, @ViewBuilder content: @escaping () -> DestinationContent) {
        self.method = method
        self.content = content
    }

    @ViewBuilder
    public func body(content: Content) -> some View {
        transitionBody(triggerBody(content))
    }
}

// MARK: - Transition

extension PresentationModifier {
    @ViewBuilder
    private func transitionBody<Content>(_ content: Content) -> some View where Content: View {
        switch method.transition {
        case .push:
            content
                .background(NavigationLink("", destination: self.content(), isActive: $isActive))
        case .sheet:
            content
                .sheet(isPresented: $isActive, content: self.content)
        case .fullScreen:
            content
                .fullScreenCover(isPresented: $isActive, content: self.content)
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
