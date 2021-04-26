//
//  GradientButtonStyle.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct GradientButtonStyle: ButtonStyle {
    private let padding: CGFloat?
    private let scaleWhenPressed: CGFloat
    private let disabled: Bool

    public init(padding: CGFloat? = nil, scaleWhenPressed: CGFloat = 0.95, disabled: Bool = false) {
        self.padding = padding
        self.scaleWhenPressed = scaleWhenPressed
        self.disabled = disabled
    }

    private var colors: [Color] {
        if disabled {
            return [.gray]
        } else {
            return [.red, .orange]
        }
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.all, padding)
            .foregroundColor(.white)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: colors),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(25)
            .shadow(radius: 5)
            .scaleEffect(configuration.isPressed ? scaleWhenPressed : 1.0)
    }
}
