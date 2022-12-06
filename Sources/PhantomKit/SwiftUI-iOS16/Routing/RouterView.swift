//
//  RouterView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct RouterView<R>: View where R: Route {
    @ObservedObject private var router: Router<R>

    public init(router: Router<R>) {
        self.router = router
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
