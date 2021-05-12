//
//  AboutView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 22.04.2021.
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
        .onTapFrame {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

extension AboutView {
    private var imageView: some View {
        image()
            .resizable()
            .scaledToFit()
            .padding()
    }

    private var sectionsView: some View {
        ForEach(sections, id: \.title) {
            Section.ContentView(section: $0)
        }
    }
}

extension AboutView {
    public init(
        image: ImageAssetIdentifier,
        sections: [Section] = []
    ) {
        self.sections = sections
        self.image = { Image(assetIdentifier: image) }
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
    public static func appDesign(author: String, startYear: Int? = nil) -> Self {
        .init(
            title: Localized.About.appDesign,
            items: [.copyright(author: author, startYear: startYear)]
        )
    }
}

extension AboutView.Section {
    public static func graphics(title: String, endpoint: WebEndpoint) -> Self {
        .init(
            title: Localized.About.graphics,
            items: [.link(title, endpoint: endpoint)]
        )
    }
}

extension AboutView.Section.Item {
    public static func copyright(author: String, startYear: Int? = nil) -> Self {
        let endYear = Date().component(.year)
        var components = ["©"]
        if let startYear = startYear {
            components.append("\(startYear) - \(endYear)")
        } else {
            components.append("\(endYear)")
        }
        components.append(author)
        return .text(components.joined(separator: " "))
    }
}
