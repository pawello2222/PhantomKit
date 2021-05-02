//
//  GradientButtonStyle.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// MARK: - Fill

public struct GradientFillButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Self.Configuration) -> some View {
        GradientFillStyleBody(id: .gradientFill, configuration: configuration) {
            RoundedRectangle(cornerRadius: $0.cornerRadius, style: .continuous)
        }
    }
}

// MARK: - Pill

public struct GradientPillButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Self.Configuration) -> some View {
        GradientFillStyleBody(id: .gradientPill, configuration: configuration) { _ in
            Capsule()
        }
    }
}

// MARK: - Helper

private struct GradientFillStyleBody<S: Shape>: View {
    @Environment(\.defaultMinButtonHeight) private var minHeight
    @Environment(\.defaultButtonCornerRadius) var cornerRadius
    @Environment(\.theme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    let id: ButtonIdentifier
    let configuration: ButtonStyleConfiguration
    let shape: (Self) -> S

    var body: some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: minHeight)
            .padding(.horizontal)
            .foregroundColor(foregroundColor)
            .background(
                shape(self)
                    .fill(LinearGradient(
                        gradient: .init(colors: gradientColors),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
            )
            .contentShape(shape(self))
            .scaleOpacityEffect(configuration.isPressed, options: .scale)
    }

    private var foregroundColor: Color {
        Color(
            isEnabled ?
                theme.buttonTextColor(id, configuration.isPressed ? .pressed : .normal) :
                theme.buttonTextColor(id, .disabled)
        )
    }

    private var gradientColors: [Color] {
        isEnabled ?
            theme.gradientColors.map(Color.init) :
            theme.gradientDisabledColors.map(Color.init)
    }
}

// MARK: - ButtonIdentifier

extension ButtonIdentifier {
    public static var gradientFill: Self { #function }
    public static var gradientPill: Self { #function }
}
