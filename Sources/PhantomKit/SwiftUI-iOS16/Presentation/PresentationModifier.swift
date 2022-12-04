//
//  PresentationModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct PresentationModifier<R>: ViewModifier where R: Route {
    private let presentation: Presentation
    private let onTrigger: (() -> Void)?
    private let onDismiss: (() -> Void)?
    private let route: R

    @State private var isActive = false

    public init(
        presentation: Presentation = .link,
        onTrigger: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        route: R
    ) {
        self.presentation = presentation
        self.onTrigger = onTrigger
        self.onDismiss = onDismiss
        self.route = route
    }

    @ViewBuilder
    public func body(content: Content) -> some View {
        transitionBody(
            content
                .modifier(
                    PresentationTriggerModifier(
                        trigger: presentation.trigger,
                        isActive: $isActive,
                        onTrigger: onTrigger
                    )
                )
        )
    }
}

// MARK: - Transition Body

extension PresentationModifier {
    @ViewBuilder
    private func transitionBody<Content>(_ content: Content) -> some View where Content: View {
        switch presentation.transition {
        case .link:
            content
                .background(NavigationLink("", destination: route.resolve(), isActive: $isActive).hidden())
        case .sheet:
            content
                .sheet(isPresented: $isActive, onDismiss: onDismiss, content: route.resolve)
        case .fullScreen:
            content
                .fullScreenCover(isPresented: $isActive, onDismiss: onDismiss, content: route.resolve)
        }
    }
}
