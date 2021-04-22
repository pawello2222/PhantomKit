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
        NavigationView {
            WebViewRepresentable(viewModel: viewModel)
                .edgesIgnoringSafeArea(viewModel.edgesIgnoringSafeArea)
                .navigationTitle(viewModel.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Done") {
                            viewModel.dismissAction()
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
        }
    }
}

// MARK: - ViewModel

extension WebView {
    public class ViewModel: ObservableObject {
        public let title: String
        @Published public var url: String
        @Published public var isNavigationAllowed: Bool
        public let edgesIgnoringSafeArea: Edge.Set
        public let dismissAction: () -> Void

        @Published public var didFinishLoading = false

        public init(
            title: String,
            url: String,
            isNavigationAllowed: Bool = true,
            edgesIgnoringSafeArea: Edge.Set = .none,
            dismissAction: @escaping () -> Void = {}
        ) {
            self.title = title
            self.url = url
            self.isNavigationAllowed = isNavigationAllowed
            self.edgesIgnoringSafeArea = edgesIgnoringSafeArea
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

// MARK: - Modifier

public struct SheetWebViewModifier: ViewModifier {
    @ObservedObject private var viewModel: WebView.ViewModel

    @State private var isLinkActive = false

    public init(viewModel: WebView.ViewModel) {
        self.viewModel = viewModel
    }

    public func body(content: Content) -> some View {
        content
            .onTap {
                isLinkActive = true
            }
            .sheet(isPresented: $isLinkActive) {
                WebView(viewModel)
            }
    }
}

extension View {
    public func sheetWebView(_ viewModel: WebView.ViewModel) -> some View {
        modifier(SheetWebViewModifier(viewModel: viewModel))
    }
}
