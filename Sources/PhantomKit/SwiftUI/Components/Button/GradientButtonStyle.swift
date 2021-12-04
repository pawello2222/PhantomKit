//
//  GradientButtonStyle.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct GradientButtonStyle<S: InsettableShape>: ButtonStyle {
    private let id: ButtonIdentifier
    private let shape: S

    public init(
        id: ButtonIdentifier,
        shape: S
    ) {
        self.id = id
        self.shape = shape
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        InternalBody(
            id: id,
            configuration: configuration,
            shape: shape
        )
    }
}

// MARK: - Internal

extension GradientButtonStyle {
    private struct InternalBody: View {
        @Environment(\.defaultMinButtonHeight) private var minHeight
        @Environment(\.appTheme) private var theme
        @Environment(\.isEnabled) private var isEnabled

        let id: ButtonIdentifier
        let configuration: ButtonStyleConfiguration
        let shape: S

        var body: some View {
            configuration.label
                .frame(maxWidth: .infinity, minHeight: minHeight)
                .padding(.horizontal)
                .foregroundColor(foregroundColor)
                .background(background)
                .contentShape(shape)
                .scaleOpacityEffect(configuration.isPressed, effects: [.scale])
        }

        private var background: some View {
            shape
                .fill(
                    LinearGradient(
                        gradient: .init(colors: gradientColors),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }

        private var foregroundColor: Color {
            isEnabled ?
                theme.buttonTextColor(id, configuration.isPressed ? .pressed : .normal) :
                theme.buttonTextColor(id, .disabled)
        }

        private var gradientColors: [Color] {
            isEnabled ?
                theme.buttonBackgroundGradientColors(configuration.isPressed ? .pressed : .normal) :
                theme.buttonBackgroundGradientColors(.disabled)
        }
    }
}

// MARK: - ButtonIdentifier

extension ButtonIdentifier {
    public static var gradient: Self { #function }
}

// MARK: - Dot Syntax Support

extension ButtonStyle {
    public static func gradient<S: InsettableShape>(shape: S) -> Self where Self == GradientButtonStyle<S> {
        .init(
            id: .gradient,
            shape: shape
        )
    }
}

extension ButtonStyle where Self == GradientButtonStyle<RoundedRectangle> {
    public static func gradient(cornerRadius: CGFloat) -> Self {
        .gradient(shape: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }

    public static var gradient: Self {
        .gradient(cornerRadius: AppConstants.buttonCornerRadius)
    }
}
