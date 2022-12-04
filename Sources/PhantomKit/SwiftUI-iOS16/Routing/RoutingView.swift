//
//  RoutingView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct RoutingView<R>: View where R: Route {
    @StateObject private var router: Router<R>

    public init(main: R) {
        _router = .init(wrappedValue: Router(main: main))
    }

    public var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: R.self) { route in
                    route.resolve()
                }
        }
        .environmentObject(router)
    }

    private var content: some View {
        ZStack {
            router.main.resolve()
            router.overlay?.resolve()
        }
    }
}
