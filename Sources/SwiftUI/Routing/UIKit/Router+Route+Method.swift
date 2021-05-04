//
//  Router+Route+Method.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 24.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension Router.Route {
    public struct Method {
        public enum Transition {
            case push
            case sheet
            case fullScreen
        }

        public let transition: Transition
        public let isAnimated: Bool

        public init(transition: Transition, animated: Bool = true) {
            self.transition = transition
            isAnimated = animated
        }

        public var isModal: Bool {
            switch transition {
            case .push:
                return false
            case .sheet, .fullScreen:
                return true
            }
        }
    }
}

// MARK: - Method: Convenience

extension Router.Route.Method {
    // Push

    public static var push: Self {
        .push(animated: true)
    }

    public static func push(animated: Bool) -> Self {
        .init(transition: .push, animated: animated)
    }

    // Sheet

    public static var sheet: Self {
        .sheet(animated: true)
    }

    public static func sheet(animated: Bool) -> Self {
        .init(transition: .sheet, animated: animated)
    }

    // Full Screen

    public static var fullScreen: Self {
        .fullScreen(animated: true)
    }

    public static func fullScreen(animated: Bool) -> Self {
        .init(transition: .fullScreen, animated: animated)
    }
}

// MARK: - Display

extension Router.Route.Method {
    func show<Content>(_ view: Content, navigationController: UINavigationController) where Content: View {
        guard isModal else {
            let pushVC = BaseHostingController(rootView: view)
            navigationController.pushViewController(pushVC, animated: isAnimated)
            return
        }

        let modalVC = BaseHostingController(rootView: view.embedInStackNavigation()).apply {
            $0.modalPresentationStyle = transition == .fullScreen ? .fullScreen : .automatic
        }
        navigationController.present(modalVC, animated: isAnimated)
    }
}
