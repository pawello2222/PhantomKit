//
//  Router.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public class Router<R>: ObservableObject where R: Route {
    @Published public var content: R
    @Published public var overlay: R?
    @Published public var path = NavigationPath()

    public init(content: R) {
        self.content = content
    }

    // MARK: - Content

    public func show(content: R) {
        popToRoot()
        self.content = content
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
