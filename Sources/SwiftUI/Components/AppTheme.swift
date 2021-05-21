//
//  AppTheme.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

@dynamicMemberLookup
public struct AppTheme: MutableAppliable, UserInfoContainer {
    public typealias Identifier = Xcore.Identifier<Self>

    /// A unique id for the theme.
    public var id: Identifier

    /// A color that represents the system or application accent color.
    public var accentColor: Color

    /// The color for border lines that hides any underlying content.
    public var borderColor: Color

    /// The color for toggle controls (e.g., Switch or Checkbox).
    public var toggleColor: Color

    /// The color for links.
    public var linkColor: Color

    // MARK: - Text

    /// The color for text labels that contain primary content.
    public var primaryColor: Color

    /// The color for text labels that contain secondary content.
    public var secondaryColor: Color

    // MARK: - Background

    /// The color for the main background of your interface.
    public var backgroundColor: Color

    /// The color for content layered on top of the main background.
    public var backgroundSecondaryColor: Color

    // MARK: - Button

    /// The color for the text of the button.
    public var buttonTextColor: Color

    /// The color for the background of the button.
    public var buttonBackgroundColor: Color

    // MARK: - Gradient

    /// The first color for linear gradients.
    public var gradientPrimaryColor: Color

    /// The second first color for linear gradients.
    public var gradientSecondaryColor: Color

    // MARK: - Sentiment Color

    /// The color for representing positive sentiment.
    ///
    /// Use sentiment colors for items that represent positive or negative outcomes.
    /// Use this color to for outcomes, such as the validation succeeded.
    public var positiveSentimentColor: Color

    /// The color for representing negative sentiment.
    ///
    /// Use sentiment colors for items that represent positive or negative outcomes.
    /// Use this color to for outcomes, such as the validation failed or require
    /// user's attention.
    public var negativeSentimentColor: Color

    /// Additional info which may be used to describe the theme further.
    public var userInfo: UserInfo

    public init(
        id: Identifier,
        accentColor: Color,
        borderColor: Color,
        toggleColor: Color,
        linkColor: Color,

        // Text
        primaryColor: Color,
        secondaryColor: Color,

        // Background
        backgroundColor: Color,
        backgroundSecondaryColor: Color,

        // Button
        buttonTextColor: Color,
        buttonBackgroundColor: Color,

        // Gradient
        gradientPrimaryColor: Color,
        gradientSecondaryColor: Color,

        // Sentiment
        positiveSentimentColor: Color,
        negativeSentimentColor: Color,

        // UserInfo
        userInfo: UserInfo = [:]
    ) {
        self.id = id
        self.accentColor = accentColor
        self.borderColor = borderColor
        self.toggleColor = toggleColor
        self.linkColor = linkColor

        // Text
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor

        // Background
        self.backgroundColor = backgroundColor
        self.backgroundSecondaryColor = backgroundSecondaryColor

        // Button
        self.buttonTextColor = buttonTextColor
        self.buttonBackgroundColor = buttonBackgroundColor

        // Gradient
        self.gradientPrimaryColor = gradientPrimaryColor
        self.gradientSecondaryColor = gradientSecondaryColor

        // Sentiment
        self.positiveSentimentColor = positiveSentimentColor
        self.negativeSentimentColor = negativeSentimentColor

        // UserInfo
        self.userInfo = userInfo
    }
}

// MARK: - KeyPath

extension AppTheme {
    public static subscript<T>(dynamicMember keyPath: KeyPath<Self, T>) -> T {
        `default`[keyPath: keyPath]
    }

    public static subscript<T>(dynamicMember keyPath: WritableKeyPath<Self, T>) -> T {
        get { `default`[keyPath: keyPath] }
        set { `default`[keyPath: keyPath] = newValue }
    }
}

// MARK: - Hashable

extension AppTheme: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Equatable

extension AppTheme: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

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

        // Button
        buttonTextColor: .accentColor,
        buttonBackgroundColor: .accentColor,

        // Gradient
        gradientPrimaryColor: .accentColor,
        gradientSecondaryColor: .accentColor,

        // Sentiment
        positiveSentimentColor: .green,
        negativeSentimentColor: .red
    )
}
