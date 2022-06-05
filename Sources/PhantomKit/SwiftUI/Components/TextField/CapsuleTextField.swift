//
//  CapsuleTextField.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 13.06.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI
import Xcore

public struct CapsuleTextField: View {
    @Environment(\.appTheme) private var theme
    private let placeholder: String
    @Binding private var text: String
    private let image: SystemAssetIdentifier
    private let onEditingChanged: (Bool) -> Void

    public init(
        _ placeholder: String = "",
        text: Binding<String>,
        image: SystemAssetIdentifier,
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) {
        self.placeholder = placeholder
        _text = text
        self.image = image
        self.onEditingChanged = onEditingChanged
    }

    public var body: some View {
        HStack {
            textView
            imageView
        }
        .backgroundColor(theme.backgroundSecondaryColor)
        .clipShape(Capsule())
    }

    private var textView: some View {
        TextField(placeholder, text: $text, onEditingChanged: onEditingChanged)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.leading)
    }

    @ViewBuilder
    private var imageView: some View {
        Image(system: image)
            .imageScale(.large)
            .padding()
    }
}
