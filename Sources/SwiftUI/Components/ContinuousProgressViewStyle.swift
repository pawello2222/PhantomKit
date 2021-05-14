//
//  ContinuousProgressViewStyle.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 14.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct ContinuousProgressViewStyle: ProgressViewStyle {
    @Environment(\.theme) private var theme
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
                .foregroundUIColor(theme.gradientColors.first ?? theme.accentColor)
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
}

extension ContinuousProgressViewStyle {
    private func trimmedCircleView(from: CGFloat, to: CGFloat) -> some Shape {
        Circle()
            .trim(from: from, to: to)
            .stroke(style: .init(lineWidth: size.width / 13, lineCap: .round, lineJoin: .round))
    }
}

extension ContinuousProgressViewStyle {
    private var gradient: LinearGradient {
        .init(
            gradient: .init(colors: [
                .init(theme.gradientColors.first ?? theme.accentColor),
                .init(theme.gradientColors.last ?? theme.accentColor),
            ]),
            startPoint: .trailing,
            endPoint: .leading
        )
    }
}

extension ContinuousProgressViewStyle {
    private func startAnimation() {
        withAnimation(Animation.easeInOut(duration: cycleInterval)) {
            trimEnd = 1
        }
        Async.main(after: cycleInterval) {
            withAnimation(Animation.easeInOut(duration: cycleInterval)) {
                trimStart = 1
            }
        }
        Async.main(after: cycleInterval * 2) {
            trimStart = 0
            trimEnd = 0
            withAnimation(Animation.easeInOut(duration: cycleInterval)) {
                startAnimation()
            }
        }
    }
}
