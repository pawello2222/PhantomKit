//
//  View+Route.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension View {
    public func route<Content, Style>(
        to view: Content,
        method: Router.Route<MainRouter>.Method = .push,
        style: Style
    ) -> some View where Content: View, Style: PrimitiveButtonStyle {
        Button {
            Router.current?.main.route(to: view, method: method)
        } label: {
            self
        }
        .buttonStyle(style)
    }
}

extension View {
    public func route<Content>(
        to view: Content,
        method: Router.Route<MainRouter>.Method = .push
    ) -> some View where Content: View {
        route(to: view, method: method, style: PlainButtonStyle())
    }
}

public struct AnyButtonStyle: PrimitiveButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}

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
