//
//  IconBadgeLabelStyle.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI
import Xcore

/// A label style that displays the icon as a rounded rectangle badge.
public struct IconBadgeLabelStyle: LabelStyle {
    @Environment(\.defaultIconHeight) private var iconHeight
    @Environment(\.appTheme) private var theme

    private let color: Color
    private let cornerRadius: CGFloat

    public init(
        color: Color,
        cornerRadius: CGFloat
    ) {
        self.color = color
        self.cornerRadius = cornerRadius
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            iconView(with: configuration)
            titleView(with: configuration)
            Spacer()
            IndicatorView()
        }
        .contentShape(Rectangle())
    }

    private func iconView(with configuration: Self.Configuration) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(color)
            .frame(iconHeight)
            .overlay(
                configuration.icon
                    .foregroundStyle(.white)
            )
    }

    private func titleView(with configuration: Self.Configuration) -> some View {
        configuration.title
            .foregroundStyle(theme.primaryColor)
    }
}

// MARK: - Dot Syntax Support

extension LabelStyle where Self == IconBadgeLabelStyle {
    /// A label style that displays the icon as a rounded rectangle badge.
    public static func iconBadge(
        color: Color,
        cornerRadius: CGFloat = AppConstants.cornerRadius
    ) -> Self {
        .init(
            color: color,
            cornerRadius: cornerRadius
        )
    }
}
