//
//  RootViewAppearance.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 03.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct RootViewAppearance: ViewModifier {
    private let theme: Theme

    public init(theme: Theme = .default) {
        self.theme = theme
    }

    public func body(content: Content) -> some View {
        content
            .accentUIColor(theme.accentColor)
            .theme(theme)
    }
}

// MARK: - View

extension View {
    public func rootViewAppearance(theme: Theme = .default) -> some View {
        modifier(RootViewAppearance(theme: theme))
    }
}
