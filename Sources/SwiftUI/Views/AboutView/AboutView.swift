//
//  AboutView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 22/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct AboutView: View {
    @Environment(\.presentationMode) private var presentationMode
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
        .padding(.maximumPadding)
        .navigationBarHidden(true)
        .frameAction {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

extension AboutView {
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

extension AboutView {
    public init(
        assetIdentifier: ImageAssetIdentifier,
        sections: [Section] = []
    ) {
        self.sections = sections
        image = { Image(assetIdentifier: assetIdentifier) }
    }
}

extension AboutView {
    public init(
        imageName: String,
        sections: [Section] = []
    ) {
        self.sections = sections
        image = { Image(imageName) }
    }
}

// MARK: - Data

extension AboutView.Section {
    public static func appDesign(author: String) -> Self {
        .init(
            title: "APP DESIGN",
            items: [.copyright(author: author)]
        )
    }
}

extension AboutView.Section {
    public static func graphics(title: String, endpoint: WebEndpoint) -> Self {
        .init(
            title: "GRAPHICS",
            items: [.link(title: title, endpoint: endpoint)]
        )
    }
}

extension AboutView.Section.Item {
    public static func copyright(author: String) -> Self {
        var components = ["©"]
        if let year = Calendar.current.year {
            components.append(String(describing: year))
        }
        components.append(author)
        return .init(title: components.joined(separator: " "))
    }
}

extension AboutView.Section.Item {
    public static func link(title: String, endpoint: WebEndpoint) -> Self {
        .init(
            title: title,
            webView: .init(endpoint)
        )
    }
}
