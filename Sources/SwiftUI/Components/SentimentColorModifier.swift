//
//  SentimentColorModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 28.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct SentimentColorModifier: ViewModifier {
    @Environment(\.appTheme) private var theme

    private let value: NSDecimalNumber

    public init(relativeTo value: NSDecimalNumber) {
        self.value = value
    }

    public func body(content: Content) -> some View {
        content
            .foregroundColor(color)
    }

    private var color: Color {
        if value == 0 {
            return theme.neutralSentimentColor
        } else if value > 0 {
            return theme.positiveSentimentColor
        } else {
            return theme.negativeSentimentColor
        }
    }
}

// MARK: - Convenience

extension SentimentColorModifier {
    public init(relativeTo value: Int) {
        self.value = NSDecimalNumber(value: value)
    }

    public init(relativeTo value: Float) {
        self.value = NSDecimalNumber(value: value)
    }

    public init(relativeTo value: Double) {
        self.value = NSDecimalNumber(value: value)
    }

    public init(relativeTo value: Decimal) {
        self.value = NSDecimalNumber(decimal: value)
    }
}

// MARK: - View

extension View {
    public func sentimentColor(relativeTo value: Int) -> some View {
        modifier(SentimentColorModifier(relativeTo: value))
    }

    public func sentimentColor(relativeTo value: Float) -> some View {
        modifier(SentimentColorModifier(relativeTo: value))
    }

    public func sentimentColor(relativeTo value: Double) -> some View {
        modifier(SentimentColorModifier(relativeTo: value))
    }

    public func sentimentColor(relativeTo value: Decimal) -> some View {
        modifier(SentimentColorModifier(relativeTo: value))
    }

    public func sentimentColor(relativeTo value: NSDecimalNumber) -> some View {
        modifier(SentimentColorModifier(relativeTo: value))
    }
}
