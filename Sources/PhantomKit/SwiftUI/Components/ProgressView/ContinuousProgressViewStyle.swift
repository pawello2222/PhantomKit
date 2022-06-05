//
//  ContinuousProgressViewStyle.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 14.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

/// A progress view in a shape of a circle that spins continuously.
public struct ContinuousProgressViewStyle: ProgressViewStyle {
    @Environment(\.appTheme) private var theme
    @State private var trimStart: CGFloat = 0
    @State private var trimEnd: CGFloat = 0
    @State private var size: CGSize = .zero
    private let cycleInterval: TimeInterval = 3

    public init() {}

    public func makeBody(configuration: Self.Configuration) -> some View {
        ZStack(alignment: .top) {
            trimmedCircleView(from: 0, to: 1)
                .fill(gradient)
                .opacity(0.3)
            trimmedCircleView(from: trimStart, to: trimEnd)
                .fill(gradient)
            trimmedCircleView(from: 0, to: 1 / 360)
                .foregroundColor(theme.buttonBackgroundGradientColors().first ?? theme.accentColor)
                .rotationEffect(.degrees(-0.5))
        }
        .rotationEffect(.degrees(-90))
        .readSize {
            size = $0
        }
        .onAppear {
            startAnimation()
        }
    }

    private var gradient: LinearGradient {
        .init(
            gradient: .init(colors: theme.buttonBackgroundGradientColors()),
            startPoint: .trailing,
            endPoint: .leading
        )
    }

    private func trimmedCircleView(from: CGFloat, to: CGFloat) -> some Shape {
        Circle()
            .trim(from: from, to: to)
            .stroke(style: .init(
                lineWidth: size.width / 13,
                lineCap: .round,
                lineJoin: .round
            ))
    }
}

// MARK: - Animation

extension ContinuousProgressViewStyle {
    private func startAnimation() {
        withAnimation(.easeInOut(duration: cycleInterval)) {
            trimEnd = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + cycleInterval) {
            withAnimation(.easeInOut(duration: cycleInterval)) {
                trimStart = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + cycleInterval * 2) {
            trimStart = 0
            trimEnd = 0
            withAnimation(.easeInOut(duration: cycleInterval)) {
                startAnimation()
            }
        }
    }
}

// MARK: - Dot Syntax Support

extension ProgressViewStyle where Self == ContinuousProgressViewStyle {
    /// A progress view in a shape of a circle that spins continuously.
    public static var continuous: Self {
        .init()
    }
}
