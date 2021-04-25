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

public struct SheetModifier<SheetContent>: ViewModifier where SheetContent: View {
    private let sheet: () -> SheetContent

    @State private var isLinkActive = false

    public init(content: @autoclosure @escaping () -> SheetContent) {
        sheet = content
    }

    public init(@ViewBuilder content: @escaping () -> SheetContent) {
        sheet = content
    }

    public func body(content: Content) -> some View {
        Button {
            isLinkActive = true
        } label: {
            content
        }
        .sheet(isPresented: $isLinkActive) {
            sheet()
        }
    }
}

extension View {
    public func sheet<Content>(_ content: Content) -> some View where Content: View {
        modifier(SheetModifier(content: content))
    }
}
