//
//  CreditsView+Section+Item.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension CreditsView.Section {
    public struct Item {
        let title: String
        let action: Action?

        public init(title: String) {
            self.title = title
            action = nil
        }

        public init(
            title: String,
            action: @escaping () -> Void
        ) {
            self.title = title
            self.action = .simple(action)
        }

        public init(
            title: String,
            webView: WebView.ViewModel
        ) {
            self.title = title
            action = .webView(webView)
        }
    }
}

// MARK: - Action

extension CreditsView.Section.Item {
    enum Action {
        case simple(() -> Void)
        case webView(WebView.ViewModel)
    }
}

// MARK: - View

extension CreditsView.Section.Item {
    struct ItemView: View {
        let item: CreditsView.Section.Item

        var body: some View {
            Text(item.title)
                .font(.app(.body, weight: .medium))
                .unwrap(item.action) {
                    $0.action($1)
                }
        }
    }
}

extension View {
    @ViewBuilder
    func action(_ action: CreditsView.Section.Item.Action) -> some View {
        switch action {
        case .simple(let action):
            onTapGesture(perform: action)
        case .webView(let viewModel):
            sheet(WebView(viewModel))
        }
    }
}
