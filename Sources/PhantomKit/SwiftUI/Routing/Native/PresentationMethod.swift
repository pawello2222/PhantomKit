//
//  PresentationMethod.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct PresentationMethod {
    public let transition: Transition
    public let trigger: Trigger

    public init(transition: Transition = .link, trigger: Trigger = .default) {
        self.transition = transition
        self.trigger = trigger
    }
}

extension PresentationMethod {
    public var isModal: Bool {
        switch transition {
        case .sheet, .fullScreen:
            return true
        case .link:
            return false
        }
    }
}

// MARK: - Transition

extension PresentationMethod {
    public enum Transition {
        case link
        case sheet
        case fullScreen
    }
}

// MARK: - Trigger

extension PresentationMethod {
    public enum Trigger {
        case tap
        case button(style: AnyButtonStyle)
        case primitiveButton(style: AnyPrimitiveButtonStyle)
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
}

// PrimitiveButtonStyle

extension PresentationMethod.Trigger {
    public static func button<S>(_ style: S) -> Self where S: PrimitiveButtonStyle {
        .primitiveButton(style: AnyPrimitiveButtonStyle(style: style))
    }

    public static var defaultButton: Self {
        .button(.default)
    }

    public static var plainButton: Self {
        .button(.plain)
    }

    public static var borderlessButton: Self {
        .button(.borderless)
    }
}

// ButtonStyle

extension PresentationMethod.Trigger {
    public static func button<S>(_ style: S) -> Self where S: ButtonStyle {
        .button(style: AnyButtonStyle(style: style))
    }

    public static var scaleButton: Self {
        .button(.scaleEffect)
    }

    public static var fillButton: Self {
        .button(.fill)
    }

    public static var outlineButton: Self {
        .button(.outline)
    }

    public static var gradientButton: Self {
        .button(.gradient)
    }
}
