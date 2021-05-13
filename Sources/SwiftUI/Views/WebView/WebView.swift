//
//  WebView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI
import WebKit

public struct WebView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        WebViewRepresentable(viewModel: viewModel)
            .navigationTitle(viewModel.endpoint.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(Localized.done) {
                        viewModel.onDismiss?()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
    }
}

// MARK: - Representable

public struct WebViewRepresentable: UIViewRepresentable {
    @ObservedObject private var viewModel: WebView.ViewModel

    public init(viewModel: WebView.ViewModel) {
        self.viewModel = viewModel
    }

    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        if let url = viewModel.endpoint.url {
            webView.load(URLRequest(url: url))
        }
        webView.allowsBackForwardNavigationGestures = viewModel.endpoint.isNavigationAllowed
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        return webView
    }

    public func updateUIView(_ uiView: WKWebView, context: Context) {}

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

        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            let scripts = [
                WebView.Script.hideElements(classNames: viewModel.endpoint.hiddenWebElements),
            ]
            webView.evaluateJavaScript(scripts.joined()) { [weak self] _, _ in
                self?.viewModel.didFinishLoading = true
            }
        }

        public func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            guard !viewModel.endpoint.isNavigationAllowed else {
                decisionHandler(.allow)
                return
            }

            guard
                let originalURL = viewModel.endpoint.url?.absoluteString,
                let destinationURL = navigationAction.request.url?.absoluteString,
                destinationURL.contains(originalURL)
            else {
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }
    }
}

// MARK: - Convenience

extension WebView {
    public init(endpoint: WebEndpoint) {
        viewModel = .init(endpoint)
    }
}
