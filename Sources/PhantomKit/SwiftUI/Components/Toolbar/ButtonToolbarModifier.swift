//
//  ButtonToolbarModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 10.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct ButtonToolbarModifier: ViewModifier {
    @Environment(\.presentationMode) private var presentationMode

    private let title: String
    private let placement: ToolbarItemPlacement
    private let onDismiss: (() -> Void)?

    public init(
        title: String,
        placement: ToolbarItemPlacement = .navigationBarLeading,
        onDismiss: (() -> Void)?
    ) {
        self.title = title
        self.placement = placement
        self.onDismiss = onDismiss
    }

    public func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: placement) {
                    Button(title) {
                        onDismiss?()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
    }
}

// MARK: - View

extension View {
    public func cancelButtonToolbar(
        _ title: String,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        modifier(
            ButtonToolbarModifier(
                title: title,
                placement: .cancellationAction,
                onDismiss: onDismiss
            )
        )
    }
}
