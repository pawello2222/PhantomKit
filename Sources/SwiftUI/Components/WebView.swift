//
//  WebView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI
import WebKit

public struct WebView: View {
    @ObservedObject private var viewModel: ViewModel

    public init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        WebViewRepresentable(viewModel: viewModel)
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
    }
}

// MARK: - ViewModel

extension WebView {
    public class ViewModel: ObservableObject {
        let title: String
        @Published var url: String
        @Published var isNavigationAllowed: Bool
        let dismissAction: (() -> Void)?

        @Published public var didFinishLoading = false

        public init(
            title: String,
            url: String,
            isNavigationAllowed: Bool = true,
            dismissAction: (() -> Void)? = nil
        ) {
            self.title = title
            self.url = url
            self.isNavigationAllowed = isNavigationAllowed
            self.dismissAction = dismissAction
        }
    }
}

// MARK: - Representable

public struct WebViewRepresentable: UIViewRepresentable {
    @ObservedObject private var viewModel: WebView.ViewModel

    private let webView = WKWebView()

    public init(viewModel: WebView.ViewModel) {
        self.viewModel = viewModel
    }

    public func makeUIView(context: UIViewRepresentableContext<Self>) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        if let url = URL(string: viewModel.url) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }

    public func updateUIView(_: WKWebView, context _: UIViewRepresentableContext<Self>) {
        return
    }

    public func makeCoordinator() -> Self.Coordinator {
        .init(viewModel)
    }
}

extension WebViewRepresentable {
    public class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebView.ViewModel

        public init(_ viewModel: WebView.ViewModel) {
            self.viewModel = viewModel
        }

        public func webView(_: WKWebView, didFinish _: WKNavigation!) {
            viewModel.didFinishLoading = true
        }

        public func webView(
            _: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            guard !viewModel.isNavigationAllowed else {
                decisionHandler(.allow)
                return
            }

            if let url = navigationAction.request.url {
                if url.absoluteString.contains(viewModel.url) {
                    decisionHandler(.allow)
                    return
                }
            }
            decisionHandler(.cancel)
        }
    }
}
