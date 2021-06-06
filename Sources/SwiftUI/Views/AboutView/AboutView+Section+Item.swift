//
//  AboutView+Section+Item.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension AboutView.Section {
    public struct Item {
        let title: String
        let content: () -> AnyView

        public init(title: String) {
            self.title = title
            content = {
                TextView(title: title)
                    .eraseToAnyView()
            }
        }

        public init(title: String, endpoint: WebEndpoint) {
            self.title = title
            content = {
                LinkView(title: title, endpoint: endpoint)
                    .eraseToAnyView()
            }
        }
    }
}

// MARK: - Views

extension AboutView.Section.Item {
    struct TextView: View {
        let title: String

        var body: some View {
            Text(title)
                .font(.body)
        }
    }
}

extension AboutView.Section.Item {
    struct LinkView: View {
        let title: String
        let endpoint: WebEndpoint

        var body: some View {
            Text(title)
                .underline()
                .font(.body)
                .webView(endpoint: endpoint)
        }
    }
}

// MARK: - Convenience

extension AboutView.Section.Item {
    public static func text(_ title: String) -> Self {
        .init(title: title)
    }
}

extension AboutView.Section.Item {
    public static func link(_ title: String, endpoint: WebEndpoint) -> Self {
        .init(title: title, endpoint: endpoint)
    }
}
