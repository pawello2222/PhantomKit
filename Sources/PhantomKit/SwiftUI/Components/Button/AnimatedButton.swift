//
//  AnimatedButton.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 18.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct AnimatedButton<Label>: View where Label: View {
    private let action: () -> Void
    private let label: () -> Label

    public init(action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label) {
        self.action = action
        self.label = label
    }

    public var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            label()
        }
    }
}

// MARK: - Convenience

extension AnimatedButton where Label == Text {
    public init(_ title: String, action: @escaping () -> Void) {
        self.init(action: action) {
            Text(title)
        }
    }
}
