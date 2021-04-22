//
//  CreditsView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 22/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

struct CreditsView: View {
    @Environment(\.theme) private var theme
    private let imageName: String
    private let sections: [Section]
    private let onDismiss: (() -> Void)?

    public init(
        imageName: String = "screen-author",
        sections: [Section] = [],
        onDismiss: (() -> Void)? = nil
    ) {
        self.imageName = imageName
        self.sections = sections
        self.onDismiss = onDismiss
    }

    public var body: some View {
        VStack(spacing: .maximumPadding) {
            ForEach(sections, id: \.title) {
                CreditsView.Section.SectionView(section: $0)
            }
        }
        .maxFrame()
//        .unwrap(onDismiss) { content, action in
//            content.frameAction(action)
//        }
    }
}

extension CreditsView {
    private var image: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .padding()
            .padding()
    }

    private var copyright: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .padding()
            .padding()
    }
}

extension CreditsView {
    public struct Section {
        public let title: String
        public let items: [Item]

        public init(title: String, items: [Item]) {
            self.title = title
            self.items = items
        }
    }
}

extension CreditsView.Section {
    struct SectionView: View {
        let section: CreditsView.Section

        var body: some View {
            VStack(spacing: .defaultPadding) {
                ForEach(section.items, id: \.title) {
                    CreditsView.Section.Item.ItemView(item: $0)
                }
            }
        }
    }
}

extension CreditsView.Section {
    public struct Item {
        public let title: String
        public let action: (() -> Void)?
        public let webView: WebView.ViewModel?

        public init(
            title: String,
            action: (() -> Void)? = nil
        ) {
            self.title = title
            self.action = action
            webView = nil
        }

        public init(
            title: String,
            webView: WebView.ViewModel?
        ) {
            self.title = title
            action = nil
            self.webView = webView
        }
    }
}

extension CreditsView.Section.Item {
    struct ItemView: View {
        @State private var linkURL: String?

        let item: CreditsView.Section.Item

        var body: some View {
            Text(item.title)
                .unwrap(item.action) {
                    $0.onTap(action: $1)
                }
                .unwrap(item.webView) {
                    $0.sheetWebView($1)
                }
        }
    }
}

extension CreditsView.Section {
    static let appDesign = Self(
        title: "APP DESIGN",
        items: [.copyright]
    )
}

extension CreditsView.Section.Item {
    static let copyright = Self(
        title: "© \(Calendar.current.year) Paweł Wiszenko"
    )
}
