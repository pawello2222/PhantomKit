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
        imageName: String,
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
        .backgroundColor(theme.backgroundColor)
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

// MARK: - Data

extension CreditsView.Section {
    public static func appDesign(author: String) -> Self {
        .init(
            title: "APP DESIGN",
            items: [.copyright(author: author)]
        )
    }
}

extension CreditsView.Section {
    public static func graphics(title: String, url: String) -> Self {
        .init(
            title: "GRAPHICS",
            items: [.link(title: title, url: url)]
        )
    }
}

extension CreditsView.Section.Item {
    public static func copyright(author: String) -> Self {
        .init(
            title: "© \(Calendar.current.year) \(author)"
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
