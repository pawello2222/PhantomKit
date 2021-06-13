//
//  SafariView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 09.06.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SafariServices
import SwiftUI

public struct SafariView: View {
    private let url: URL

    public init(url: URL) {
        self.url = url
    }

    public var body: some View {
        SafariViewRepresentable(url: url)
            .ignoresSafeArea()
    }
}

// MARK: - Representable

public struct SafariViewRepresentable: UIViewControllerRepresentable {
    @Environment(\.appTheme) private var theme

    private let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url).apply {
            $0.preferredControlTintColor = .init(theme.accentColor)
        }
    }

    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

// MARK: - View

extension View {
    public func safariView(
        openedAs method: PresentationMethod = .fullScreen,
        url: URL?
    ) -> some View {
        unwrap(url) { content, url in
            content.presentation(method: method) {
                SafariView(url: url)
            }
        }
    }

    public func safariView(
        openedAs method: PresentationMethod = .fullScreen,
        endpoint: WebEndpoint
    ) -> some View {
        safariView(openedAs: method, url: endpoint.url)
    }

    public func safariView(
        triggeredBy trigger: PresentationMethod.Trigger,
        url: URL?
    ) -> some View {
        safariView(openedAs: .fullScreen(trigger: trigger), url: url)
    }

    public func safariView(
        triggeredBy trigger: PresentationMethod.Trigger,
        endpoint: WebEndpoint
    ) -> some View {
        safariView(triggeredBy: trigger, url: endpoint.url)
    }
}
