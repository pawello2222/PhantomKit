//
//  WebView+Route.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension RouteHandler {
    public func webView<Content>(_ view: Content, method: Method = .sheet) where Content: View {
        let destination = view
            .navigationBarItems(
                leading: Button("Done") { [weak self] in
                    self?.dismiss(method)
                }
            )
        route(to: destination, method: method)
    }
}

extension View {
    public func webView(
        _ viewModel: WebView.ViewModel,
        method: Router.Route<MainRouter>.Method = .sheet
    ) -> some View {
        let destination = WebView(viewModel)
            .navigationBarItems(
                leading: Button("Done") {
                    Router.current?.main.dismiss(method)
                }
            )
        return route(to: destination, method: method, style: PlainButtonStyle())
    }
}
