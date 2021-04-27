//
//  Router+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 22/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public final class MainRouter: RouteHandler {}

extension Router {
    public var main: MainRouter {
        register(.init())
    }
}

extension RouteHandler {
    public typealias Method = Router.Route<Self>.Method

    public func route<Content>(to view: Content, method: Method = .push) where Content: View {
        guard let navigationController = navigationController else {
            return
        }
        method.show(view, navigationController: navigationController)
    }

    public func dismiss(_ method: Method = .push) {
        guard let navigationController = navigationController else {
            return
        }
        if method.isModal {
            navigationController.dismiss(animated: method.isAnimated, completion: nil)
        } else {
            navigationController.popViewController(animated: method.isAnimated)
        }
    }

    public func dismissToRoot(isAnimated: Bool) {
        guard let navigationController = navigationController else {
            return
        }
        navigationController.popToRootViewController(animated: isAnimated)
    }
}

extension RouteHandler {
    public func sheet<Content>(_ view: Content) where Content: View {
        route(to: view, method: .sheet)
    }

    public func fullScreen<Content>(_ view: Content) where Content: View {
        route(to: view, method: .fullScreen)
    }

    public func dismiss() {
        dismiss(.push)
    }

    public func dismissToRoot() {
        dismissToRoot(isAnimated: true)
    }
}
