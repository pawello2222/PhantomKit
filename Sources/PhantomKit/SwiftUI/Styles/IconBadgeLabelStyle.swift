//
//  IconBadgeLabelStyle.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI
import Xcore

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
            .foregroundColor(theme.primaryColor)
    }
}

// MARK: - Dot Syntax Support

extension LabelStyle where Self == IconBadgeLabelStyle {
    public static func iconBadge(color: Color, cornerRadius: CGFloat) -> Self {
        .init(
            color: color,
            cornerRadius: cornerRadius
        )
    }

    public static var iconBadge: Self {
        .iconBadge(color: .clear, cornerRadius: AppConstants.cornerRadius)
    }
}
