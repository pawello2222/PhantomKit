//
//  AppTheme.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI
import Xcore

@dynamicMemberLookup
public struct AppTheme: MutableAppliable, UserInfoContainer {
    public typealias Identifier = Xcore.Identifier<Self>
    public typealias ButtonColor = (ButtonIdentifier, ButtonState) -> Color
    public typealias ButtonGradientColors = (ButtonState) -> [Color]

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

    // MARK: - Sentiment Color

    /// The color for representing positive sentiment.
    public var positiveSentimentColor: Color

    /// The color for representing neutral sentiment.
    public var neutralSentimentColor: Color

    /// The color for representing negative sentiment.
    public var negativeSentimentColor: Color

    // MARK: - Button

    /// The color for the text of the button.
    public var buttonTextColor: ButtonColor

    /// The color for the background of the button.
    public var buttonBackgroundColor: ButtonColor

    /// The color for the background of the button.
    public var buttonBackgroundGradientColors: ButtonGradientColors

    // MARK: - User Info

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

        // Sentiment
        positiveSentimentColor: Color,
        neutralSentimentColor: Color,
        negativeSentimentColor: Color,

        // Button
        buttonTextColor: @escaping ButtonColor,
        buttonBackgroundColor: @escaping ButtonColor,
        buttonBackgroundGradientColors: @escaping ButtonGradientColors,

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

        // Sentiment
        self.positiveSentimentColor = positiveSentimentColor
        self.neutralSentimentColor = neutralSentimentColor
        self.negativeSentimentColor = negativeSentimentColor

        // Button
        self.buttonTextColor = buttonTextColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.buttonBackgroundGradientColors = buttonBackgroundGradientColors

        // UserInfo
        self.userInfo = userInfo
    }
}

// MARK: - Convenience

extension AppTheme {
    public func buttonTextColor(_ state: ButtonState = .normal) -> Color {
        buttonTextColor(.plain, state)
    }

    public func buttonBackgroundColor(_ state: ButtonState = .normal) -> Color {
        buttonBackgroundColor(.plain, state)
    }

    public func buttonBackgroundGradientColors(_ state: ButtonState = .normal) -> [Color] {
        buttonBackgroundGradientColors(state)
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
