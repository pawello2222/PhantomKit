//
//  PresentationMethod.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct PresentationMethod {
    public enum Transition {
        case link
        case sheet
        case fullScreen
    }

    public enum Trigger {
        case tap
        case button(style: AnyButtonStyle)
        case primitiveButton(style: AnyPrimitiveButtonStyle)
    }

    public let transition: Transition
    public let trigger: Trigger

    public init(transition: Transition = .link, trigger: Trigger = .default) {
        self.transition = transition
        self.trigger = trigger
    }

    public var isModal: Bool {
        switch transition {
        case .sheet, .fullScreen:
            return true
        case .link:
            return false
        }
    }
}

// MARK: - Convenience

extension PresentationMethod {
    public static var link: Self {
        .link(trigger: .default)
    }

    public static func link(trigger: Trigger) -> Self {
        .init(transition: .link, trigger: trigger)
    }

    public static var sheet: Self {
        .sheet(trigger: .default)
    }

    public static func sheet(trigger: Trigger) -> Self {
        .init(transition: .sheet, trigger: trigger)
    }

    public static var fullScreen: Self {
        .fullScreen(trigger: .default)
    }

    public static func fullScreen(trigger: Trigger) -> Self {
        .init(transition: .fullScreen, trigger: trigger)
    }
}

// MARK: - Convenience + Trigger

extension PresentationMethod.Trigger {
    public static var `default`: Self = .defaultButton

    // ButtonStyle

    public static func styledButton<S>(_ style: S) -> Self where S: ButtonStyle {
        .button(style: AnyButtonStyle(style: style))
    }

    public static var scaleButton: Self {
        .styledButton(ScaleEffectButtonStyle())
    }

    public static var fillButton: Self {
        .styledButton(FillButtonStyle())
    }

    public static var pillButton: Self {
        .styledButton(PillButtonStyle())
    }

    public static var outlineButton: Self {
        .styledButton(OutlineButtonStyle())
    }

    public static var gradientFillButton: Self {
        .styledButton(GradientFillButtonStyle())
    }

    public static var gradientPillButton: Self {
        .styledButton(GradientPillButtonStyle())
    }

    // PrimitiveButtonStyle

    public static func styledButton<S>(_ style: S) -> Self where S: PrimitiveButtonStyle {
        .primitiveButton(style: AnyPrimitiveButtonStyle(style: style))
    }

    public static var defaultButton: Self {
        .styledButton(DefaultButtonStyle())
    }

    public static var plainButton: Self {
        .styledButton(PlainButtonStyle())
    }

    public static var borderlessButton: Self {
        .styledButton(BorderlessButtonStyle())
    }
}
