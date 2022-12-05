//
//  RouterView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct RouterView<R>: View where R: Route {
    @StateObject private var router: Router<R>

    public init(router: Router<R>) {
        _router = .init(wrappedValue: router)
    }

    public var body: some View {
        ZStack {
            NavigationStack(path: $router.path) {
                router.content.view()
                    .navigationDestination(for: R.self) { route in
                        route.view()
                    }
            }
            router.overlay?.view()
        }
        .environmentObject(router)
    }
}
