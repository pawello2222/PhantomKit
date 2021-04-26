//
//  ExtendedLabel.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct ExtendedLabel<Label>: View where Label: View {
    @Environment(\.defaultIconHeight) private var iconHeight
    @Environment(\.defaultButtonCornerRadius) private var cornerRadius
    private let image: Image?
    private let color: Color
    private let label: () -> Label

    public init(
        image: Image? = nil,
        color: Color = .clear,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.image = image
        self.color = color
        self.label = label
    }

    public var body: some View {
        HStack(spacing: .minimumPadding) {
            imageView
            label()
            Spacer()
            indicatorView
        }
        .contentShape(Rectangle())
    }

    @ViewBuilder
    private var imageView: some View {
        if let image = image {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(color)
                .frame(iconHeight)
                .overlay(
                    image
                        .foregroundColor(.white)
                )
        }
    }

    private var indicatorView: some View {
        Image(system: .chevronRight)
            .imageScale(.small)
            .font(.app(.body, weight: .semibold))
            .foregroundUIColor(.darkGray)
    }
}

// MARK: - Environment Values

extension EnvironmentValues {
    private struct DefaultIconHeightKey: EnvironmentKey {
        static var defaultValue: CGFloat = 32
    }

    public var defaultIconHeight: CGFloat {
        get { self[DefaultIconHeightKey.self] }
        set { self[DefaultIconHeightKey.self] = newValue }
    }
}

// MARK: - Convenience

extension ExtendedLabel {
    public init(
        text: String,
        imageName: String,
        color: Color = .clear
    ) where Label == Text {
        self.init(image: Image(systemName: imageName), color: color) {
            Text(text)
        }
    }

    public init(
        text: String,
        assetIdentifier: ImageAssetIdentifier,
        color: Color = .clear
    ) where Label == Text {
        self.init(image: Image(assetIdentifier: assetIdentifier), color: color) {
            Text(text)
        }
    }
}
