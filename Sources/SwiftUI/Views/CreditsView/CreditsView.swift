//
//  CreditsView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 22/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct CreditsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.theme) private var theme
    private let sections: [Section]
    private let image: () -> Image

    public init(
        sections: [Section] = [],
        @ViewBuilder image: @escaping () -> Image
    ) {
        self.sections = sections
        self.image = image
    }

    public var body: some View {
        VStack(spacing: .maximumPadding) {
            imageView
            sectionsView
        }
        .backgroundColor(theme.backgroundColor)
        .padding(.maximumPadding)
        .navigationBarHidden(true)
        .frameAction {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

extension CreditsView {
    private var imageView: some View {
        image()
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

extension CreditsView {
    public init(
        assetIdentifier: ImageAssetIdentifier,
        sections: [Section] = []
    ) {
        self.sections = sections
        image = { Image(assetIdentifier: assetIdentifier) }
    }
}

extension CreditsView {
    public init(
        imageName: String,
        sections: [Section] = []
    ) {
        self.sections = sections
        image = { Image(imageName) }
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
