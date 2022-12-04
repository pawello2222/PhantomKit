//
//  Router.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

class Router<R>: ObservableObject where R: Route {
    @Published private(set) var content: R
    @Published private(set) var overlay: R?
    @Published var path = NavigationPath()

    @Published var sheet: R?

    init(content: R) {
        self.content = content
    }

    // MARK: - Content

    func show(content: R) {
        popToRoot()
        self.content = content
    }

    // MARK: - Overlay

    func show(overlay: R) {
        self.overlay = overlay
    }

    func hideOverlay() {
        overlay = nil
    }

    // MARK: - Path Navigation

    func navigate(to route: R) {
        path.append(route)
    }

    func replace(last: Int = 1, with route: R) {
        path.removeLast()
        path.append(route)
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
