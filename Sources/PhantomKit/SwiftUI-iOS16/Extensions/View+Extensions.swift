//
//  View+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04.12.2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// MARK: - AnyView

extension View {
    /// Wraps this view with a type eraser.
    ///
    /// - Returns: An `AnyView` wrapping this view.
    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

// MARK: - Apply

extension View {
    /// Applies the given transform to this view.
    public func apply(@ViewBuilder transform: (Self) -> some View) -> some View {
        transform(self)
    }

    /// Applies the given transform to this view if the given condition
    /// is satisfied.
    ///
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to this `View`.
    ///
    /// - Returns: The transformed view if the condition is satisfied,
    ///   otherwise the unmodified original view.
    @ViewBuilder
    public func apply(
        if condition: Bool,
        @ViewBuilder transform: (Self) -> some View
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    /// Unwraps the given optional value and if it's non-`nil` passes it
    /// to the transform that is then applied to this view.
    ///
    /// - Parameters:
    ///   - value: The value to unwrap.
    ///   - transform: The transform to apply to this `View`.
    ///
    /// - Returns: The transformed view if the value is non-`nil`,
    ///   otherwise the unmodified original view.
    @ViewBuilder
    public func apply<Value>(
        unwrapping value: Value?,
        @ViewBuilder transform: (Self, Value) -> some View
    ) -> some View {
        if let value {
            transform(self, value)
        } else {
            self
        }
    }
}

// MARK: - FixedSize

extension View {
    /// Fixes this view at its ideal size on the given axis.
    ///
    /// - Parameters:
    ///   - axis: A Boolean value that indicates on which axis to fix the size
    ///     of the view.
    ///
    /// - Returns: A view that fixes this view at its ideal size on the given `axis`.
    public func fixedSize(_ axis: Axis) -> some View {
        switch axis {
        case .horizontal:
            return fixedSize(horizontal: true, vertical: false)
        case .vertical:
            return fixedSize(horizontal: false, vertical: true)
        }
    }
}

// MARK: - Frame

extension View {
    /// Positions this view within an invisible frame with the specified size.
    public func frame(_ size: CGFloat, alignment: Alignment = .center) -> some View {
        frame(width: size, height: size, alignment: alignment)
    }

    /// Positions this view within an invisible frame having the specified size
    /// constraints.
    public func frame(min: CGFloat, alignment: Alignment = .center) -> some View {
        frame(minWidth: min, minHeight: min, alignment: alignment)
    }

    /// Positions this view within an invisible frame having the specified size
    /// constraints.
    public func frame(max: CGFloat, alignment: Alignment = .center) -> some View {
        frame(maxWidth: max, maxHeight: max, alignment: alignment)
    }

    /// Defines the default rectangular content shape for this view.
    ///
    /// - Parameters:
    ///   - expanding: A Boolean that indicates whether the frame should expand
    ///   taking as much place possible.
    ///
    /// - Returns: A view with the rectangular content shape that is expanded
    ///   if specified.
    public func contentFrame(expanding: Bool = true) -> some View {
        frame(max: expanding ? .infinity : nil)
            .contentShape(Rectangle())
    }
}
