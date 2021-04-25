//
//  CreditsView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 22/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct CreditsView: View {
    @Environment(\.theme) private var theme
    private let imageName: String
    private let sections: [Section]

    public init(
        imageName: String = "screen-author",
        sections: [Section] = []
    ) {
        self.imageName = imageName
        self.sections = sections
    }

    public var body: some View {
        VStack(spacing: .maximumPadding) {
            imageView
            sectionsView
        }
        .navigationBarHidden(true)
    }
}

extension CreditsView {
    private var imageView: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .padding(.maximumPadding)
    }

    private var sectionsView: some View {
        ForEach(sections, id: \.title) {
            Section.SectionView(section: $0)
        }
    }
}

// MARK: - Section

extension CreditsView {
    public struct Section {
        let title: String
        let items: [Item]

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
                Text(section.title)
                    .font(.app(.subheadline, weight: .semibold))
                    .fgColor(.secondary)
                ForEach(section.items, id: \.title) {
                    CreditsView.Section.Item.ItemView(item: $0)
                }
            }
        }
    }
}

// MARK: - Item

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

extension CreditsView.Section.Item {
    enum Action {
        case simple(() -> Void)
        case webView(WebView.ViewModel)
    }
}

extension CreditsView.Section.Item {
    struct ItemView: View {
        let item: CreditsView.Section.Item

        var body: some View {
            Text(item.title)
                .font(.app(.body, weight: .medium))
        }

        @ViewBuilder
        func actionView<Content>(content: Content) -> some View where Content: View {
            switch item.action! {
            case .simple(let action):
                content.onTapGesture(perform: action)
            case .webView(let viewModel):
                content.sheet(WebView(viewModel))
            }
        }
    }
}

// MARK: - Data

extension CreditsView.Section {
    public static func appDesign(author: String) -> Self {
        .init(
            title: "APP DESIGN",
            items: [.copyright(author: author)]
        )
    }
}

extension CreditsView.Section.Item {
    public static func copyright(author _: String) -> Self {
        .init(
            title: "© \(Calendar.current.year) Paweł Wiszenko"
        )
    }
}

extension CreditsView.Section.Item {
    public static func link(title: String, url: String) -> Self {
        .init(
            title: title,
            webView: .init(
                title: title,
                url: url
            )
        )
    }
}
