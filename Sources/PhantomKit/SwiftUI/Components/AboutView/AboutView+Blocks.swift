//
//  AboutView+Blocks.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// MARK: - Common

extension AboutView where Header == EmptyView, Footer == EmptyView, Content == EmptyView {
    public static func logo(_ imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .padding()
    }

    public static func section<C>(
        title: String,
        @ViewBuilder content: @escaping () -> C
    ) -> some View where C: View {
        VStack(spacing: .s4) {
            Text(title.uppercased())
                .font(.subheadline)
                .foregroundStyle(.secondary)
            content()
        }
    }

    public static func text(_ title: String) -> some View {
        Text(title)
            .font(.body)
    }

    public static func link(_ title: String, endpoint: WebEndpoint) -> some View {
        Text(title)
            .underline()
            .font(.body)
            .safariView(endpoint: endpoint)
    }

    public static func copyright(author: String, startYear: Int? = nil) -> some View {
        let endYear = Date().component(.year)
        var components = ["©"]
        if let startYear = startYear, startYear < endYear {
            components.append("\(startYear)-\(endYear)")
        } else {
            components.append("\(endYear)")
        }
        components.append(author)
        return Text(components.joined(separator: " "))
            .font(.callout)
    }
}

// MARK: - Convenience

extension AboutView where Header == EmptyView, Footer == EmptyView, Content == EmptyView {
    public static func logo(asset: ImageAssetIdentifier) -> some View {
        AboutView.logo(asset.rawValue)
    }

    public static func section(title: String, text: String) -> some View {
        AboutView.section(title: title) {
            AboutView.text(text)
        }
    }
}
