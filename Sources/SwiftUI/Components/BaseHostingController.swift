//
//  BaseHostingController.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 24/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

open class BaseHostingController<Content>: UIHostingController<AnyView> where Content: View {
    private let theme: Theme
    private let base: BaseHostingView<Content>

    var navigationBarBackground: Chrome.Style?

    public init(rootView: Content, theme: Theme = .default) {
        self.theme = theme
        base = BaseHostingView(theme: theme, content: rootView)
        super.init(rootView: base.eraseToAnyView())
    }

    @available(*, unavailable)
    override public init(rootView _: AnyView) {
        fatalError()
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError()
    }

    override open func viewWillDismiss(using method: DismissMethod) {
        base.willDismiss(using: method)
    }

//    override open var preferredNavigationBarTintColor: UIColor {
//        theme.accentColor
//    }
//
//    override open var preferredNavigationBarBackground: Chrome.Style {
//        navigationBarBackground ?? theme.chrome
//    }
//
//    override open var preferredStatusBarBackground: Chrome.Style {
//        guard preferredNavigationBarBackground.isTransparent else {
//            return .transparent
//        }
//        return theme.chrome
//    }
//
//    override open var preferredStatusBarStyle: UIStatusBarStyle {
//        theme.statusBarStyle
//    }
}
