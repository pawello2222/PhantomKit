//
//  IconBadgeLabelStyle.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct IconBadgeLabelStyle: LabelStyle {
    @Environment(\.defaultIconHeight) private var iconHeight
    @Environment(\.defaultButtonCornerRadius) private var cornerRadius
    @Environment(\.appTheme) private var theme
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
            .foregroundColor(theme.primaryColor)
    }
}

// MARK: - Convenience

extension IconBadgeLabelStyle {
    public init(uiColor: UIColor = .clear) {
        self.init(color: .init(uiColor))
    }
}
