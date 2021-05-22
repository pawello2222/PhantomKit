//
//  DoneButtonModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 10.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct ButtonToolbarModifier: ViewModifier {
    @Environment(\.presentationMode) private var presentationMode

    private let title: String

    public init(title: String) {
        self.title = title
    }

    public func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(title) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
    }
}

// MARK: View

extension View {
    public func cancelButtonToolbar() -> some View {
        modifier(ButtonToolbarModifier(title: Localized.cancel))
    }

    public func doneButtonToolbar() -> some View {
        modifier(ButtonToolbarModifier(title: Localized.done))
    }
}
