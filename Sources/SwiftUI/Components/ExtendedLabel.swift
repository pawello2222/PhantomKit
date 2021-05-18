//
//  ExtendedLabel.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct BadgeIconLabelStyle: LabelStyle {
    @Environment(\.defaultIconHeight) private var iconHeight
    @Environment(\.defaultButtonCornerRadius) private var cornerRadius
    @Environment(\.theme) private var theme
    private let color: Color

    public init(color: Color = .clear) {
        self.color = color
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            imageView(with: configuration)
            labelView(with: configuration)
            Spacer()
            IndicatorView()
        }
        .contentShape(Rectangle())
    }

    private func imageView(with configuration: Self.Configuration) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(color)
            .frame(iconHeight)
            .overlay(
                configuration.icon
                    .foregroundColor(.white)
            )
    }

    private func labelView(with configuration: Self.Configuration) -> some View {
        configuration.title
            .foregroundUIColor(theme.textColor)
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
