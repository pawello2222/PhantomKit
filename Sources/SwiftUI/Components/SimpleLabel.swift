//
//  SimpleLabel.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 28/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct SimpleLabel<Label>: View where Label: View {
    @Environment(\.theme) private var theme
    private let image: Image
    private let label: () -> Label

    public init(
        image: Image,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.image = image
        self.label = label
    }

    public var body: some View {
        HStack {
            label()
            Spacer()
            imageView
        }
        .contentShape(Rectangle())
    }

    @ViewBuilder
    private var imageView: some View {
        image
            .imageScale(.large)
            .foregroundUIColor(theme.accentColor)
    }
}

// MARK: - Convenience

extension SimpleLabel {
    public init(
        _ title: String,
        systemImage: SystemAssetIdentifier
    ) where Label == Text {
        self.init(image: Image(system: systemImage)) {
            Text(title)
        }
    }
}
