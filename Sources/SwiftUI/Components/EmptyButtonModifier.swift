//
//  EmptyButtonModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 17.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct EmptyButtonModifier<S>: ViewModifier where S: ButtonStyle {
    private let style: S

    public init(style: S) {
        self.style = style
    }

    public func body(content: Content) -> some View {
        Button(action: {}) {
            content
        }
        .buttonStyle(style)
    }
}
