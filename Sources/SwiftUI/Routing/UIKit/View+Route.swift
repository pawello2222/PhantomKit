//
//  View+Route.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25.04.2021.
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
