//
//  PresentationMethod.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct PresentationMethod {
    public enum Transition {
        case push
        case sheet
        case fullScreen
    }

    public enum Trigger {
        case tap
        case button
    }

    public let transition: Transition
    public let trigger: Trigger

    public init(transition: Transition = .push, trigger: Trigger = .button) {
        self.transition = transition
        self.trigger = trigger
    }
}

// MARK: - Convenience

extension PresentationMethod {
    public static var push: Self {
        .push(trigger: .button)
    }

    public static func push(trigger: Trigger) -> Self {
        .init(transition: .push, trigger: trigger)
    }

    public static var sheet: Self {
        .sheet(trigger: .button)
    }

    public static func sheet(trigger: Trigger) -> Self {
        .init(transition: .sheet, trigger: trigger)
    }

    public static var fullScreen: Self {
        .fullScreen(trigger: .button)
    }

    public static func fullScreen(trigger: Trigger) -> Self {
        .init(transition: .fullScreen, trigger: trigger)
    }
}

// MARK: - Modifier

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

    @ViewBuilder
    private func transitionBody<Content>(_ content: Content) -> some View where Content: View {
        switch method.transition {
        case .push:
            content
                .background(NavigationLink("", destination: self.content(), isActive: $isActive))
        case .sheet:
            content.sheet(isPresented: $isActive, content: self.content)
        case .fullScreen:
            content.fullScreenCover(isPresented: $isActive, content: self.content)
        }
    }

    @ViewBuilder
    private func triggerBody(_ content: Content) -> some View {
        switch method.trigger {
        case .tap:
            content
                .onTapGesture {
                    isActive = true
                }
        case .button:
            Button {
                isActive = true
            } label: {
                content
                    .contentShape(Rectangle())
            }
        }
    }
}

public struct AnyButtonStyle: PrimitiveButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}
