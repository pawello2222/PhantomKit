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
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var viewModel: ViewModel

    public init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        WebViewRepresentable(viewModel: viewModel)
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
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

    public func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<Self>) {}

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
            viewModel.didFinishLoading = true
        }

        public func webView(
            _ webView: WKWebView,
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
