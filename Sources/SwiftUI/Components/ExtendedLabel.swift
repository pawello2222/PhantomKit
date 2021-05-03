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
    @Environment(\.theme) private var theme
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
        HStack {
            imageView
            labelView
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

    private var labelView: some View {
        label()
            .foregroundUIColor(theme.textColor)
    }

    private var indicatorView: some View {
        Image(system: .chevronRight)
            .imageScale(.small)
            .font(Font.body.weight(.semibold))
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
        _ title: String,
        systemImage: SystemAssetIdentifier,
        color: Color = .clear
    ) where Label == Text {
        self.init(image: Image(system: systemImage), color: color) {
            Text(title)
        }
    }

    public init(
        _ title: String,
        systemImage: SystemAssetIdentifier,
        uiColor: UIColor = .clear
    ) where Label == Text {
        self.init(title, systemImage: systemImage, color: .init(uiColor))
    }

    public init(
        _ title: String,
        image: ImageAssetIdentifier,
        color: Color = .clear
    ) where Label == Text {
        self.init(image: Image(assetIdentifier: image), color: color) {
            Text(title)
        }
    }
}
