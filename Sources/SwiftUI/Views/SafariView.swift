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
    public func safariView(url: URL) -> some View {
        fullScreen {
            SafariView(url: url)
        }
    }

    public func safariView(url: URL?) -> some View {
        unwrap(url) {
            $0.safariView(url: $1)
        }
    }

    public func safariView(endpoint: WebEndpoint) -> some View {
        safariView(url: endpoint.url)
    }
}
