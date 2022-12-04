//
//  Router.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public class Router<R>: ObservableObject where R: Route {
    @Published public var main: R
    @Published public var overlay: R?
    @Published public var path = NavigationPath()

    public init(main: R) {
        self.main = main
    }

    // MARK: - Content

    public func show(main: R) {
        popToRoot()
        self.main = main
    }

    // MARK: - Overlay

    public func show(overlay: R) {
        self.overlay = overlay
    }

    public func hideOverlay() {
        overlay = nil
    }

    // MARK: - Path Navigation

    public func navigate(to route: R) {
        path.append(route)
    }

    public func replace(last: Int = 1, with route: R) {
        path.removeLast()
        path.append(route)
    }

    public func popToRoot() {
        path.removeLast(path.count)
    }
}
