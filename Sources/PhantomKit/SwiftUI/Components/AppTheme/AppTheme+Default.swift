//
//  AppTheme+Default.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 13.10.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

// MARK: - Default

extension AppTheme {
    /// The default theme for the interface.
    public static var `default`: AppTheme = .system

    /// The system theme for the interface.
    private static let system = AppTheme(
        id: "system",
        accentColor: .accentColor,
        borderColor: .accentColor,
        toggleColor: .accentColor,
        linkColor: .accentColor,

        // Text
        primaryColor: .primary,
        secondaryColor: .secondary,

        // Background
        backgroundColor: .init(.systemBackground),
        backgroundSecondaryColor: .init(.secondarySystemBackground),

        // Sentiment
        positiveSentimentColor: .green,
        neutralSentimentColor: .gray,
        negativeSentimentColor: .red,

        // Button Text
        buttonTextColor: { style, state in
            switch (style, state) {
            case (.outline, .normal),
                 (.outline, .pressed):
                return .primary

            case (_, .normal):
                return .white
            case (_, .pressed):
                return .white
            case (_, .disabled):
                return .secondary
            }
        },

        // Button Background
        buttonBackgroundColor: { style, state in
            switch (style, state) {
            case (_, .normal):
                return .accentColor
            case (_, .pressed):
                return .accentColor
            case (_, .disabled):
                return .gray
            }
        },

        // Button Background
        buttonBackgroundGradientColors: { state in
            switch state {
            case .disabled:
                return [.gray]
            default:
                return [.accentColor]
            }
        }
    )
}

// MARK: - Common Theme

extension AppTheme {
    public static let common: AppTheme = .system.applying {
        $0.id = "common"
        $0.buttonBackgroundGradientColors = { state in
            switch state {
            case .disabled:
                return [.gray, .init(.lightGray)]
            default:
                return [.red, .orange]
            }
        }
    }
}
