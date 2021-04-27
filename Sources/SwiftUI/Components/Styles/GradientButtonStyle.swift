//
//  GradientButtonStyle.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension ButtonIdentifier {
    public static var gradientFill: Self { #function }
    public static var gradientPill: Self { #function }
}

extension UserInfoKey where Type == Theme {
    public static var gradientColors: Self { #function }
    public static var gradientDisabledColors: Self { #function }
}

extension Theme {
    public var gradientColors: [UIColor] {
        userInfo[.gradientColors] as? [UIColor] ?? [.systemTint]
    }

    public var gradientDisabledColors: [UIColor] {
        userInfo[.gradientDisabledColors] as? [UIColor] ?? [.secondarySystemBackground]
    }
}

extension Theme {
    public static var `default`: Theme = .default
}

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

    private var backgroundColor: Color {
        Color(
            isEnabled ?
                theme.buttonBackgroundColor(id, configuration.isPressed ? .pressed : .normal) :
                theme.buttonBackgroundColor(id, .disabled)
        )
    }

    private var gradientColors: [Color] {
        isEnabled ?
            theme.gradientColors.map(Color.init) :
            theme.gradientDisabledColors.map(Color.init)
    }
}
