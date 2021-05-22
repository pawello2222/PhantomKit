//
//  DoneButtonModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 10.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct DoneButtonModifier: ViewModifier {
    @Environment(\.presentationMode) private var presentationMode

    public func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(Localized.done) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
    }
}

// MARK: View

extension View {
    public func doneButtonToolbar() -> some View {
        modifier(DoneButtonModifier())
    }
}
