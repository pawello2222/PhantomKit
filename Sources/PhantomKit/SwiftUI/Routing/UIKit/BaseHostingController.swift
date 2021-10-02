//
//  BaseHostingController.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 24.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

open class BaseHostingController<Content>: UIHostingController<AnyView> where Content: View {
    private let theme: Theme

    public init(rootView: Content, theme: Theme = .default) {
        self.theme = theme
        let baseView = BaseHostingView(theme: theme, content: rootView)
        super.init(rootView: baseView.eraseToAnyView())
    }

    @available(*, unavailable)
    override public init(rootView: AnyView) {
        fatalError()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError()
    }

    override open var preferredNavigationBarTintColor: UIColor {
        theme.accentColor
    }

    override open var preferredNavigationBarBackground: Chrome.Style {
        theme.chrome
    }

    override open var preferredStatusBarBackground: Chrome.Style {
        theme.chrome
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        theme.statusBarStyle
    }
}
