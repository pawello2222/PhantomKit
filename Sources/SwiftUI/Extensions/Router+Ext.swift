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

extension Router.Route {
    public init<V: View>(_ configure: @autoclosure @escaping () -> V) {
        self.init { _ -> Router.RouteType in
            .viewController(UIHostingController(rootView: configure()))
        }
    }
}

extension RouteHandler {
    public func route<V: View>(to view: V, options: Options = .modal) {
        route(to: .init(view), options: options)
    }
}
