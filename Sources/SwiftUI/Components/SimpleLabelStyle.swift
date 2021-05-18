//
//  SimpleLabelStyle.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 28.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct SimpleLabelStyle: LabelStyle {
    @Environment(\.theme) private var theme

    public init() {}

    public func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            labelView(with: configuration)
            Spacer()
            imageView(with: configuration)
        }
        .contentShape(Rectangle())
    }

    private func imageView(with configuration: Self.Configuration) -> some View {
        configuration.icon
            .imageScale(.large)
            .foregroundUIColor(theme.accentColor)
    }

    private func labelView(with configuration: Self.Configuration) -> some View {
        configuration.title
            .foregroundUIColor(theme.textColor)
    }
}
