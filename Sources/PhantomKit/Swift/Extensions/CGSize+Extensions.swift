//
//  CGSize+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 19/06/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

import CoreGraphics

extension CGSize {
    /// Returns the lesser of width and height.
    public var min: CGFloat {
        Swift.min(width, height)
    }

    /// Returns the greater of width and height.
    public var max: CGFloat {
        Swift.max(width, height)
    }
}

extension CGSize {
    public init(_ value: CGFloat) {
        self = CGSize(width: value, height: value)
    }

    public static func += (lhs: inout Self, rhs: Self) {
        lhs.width += rhs.width
        lhs.height += rhs.height
    }

    public static func += (lhs: inout Self, rhs: CGFloat) {
        lhs = lhs + rhs
    }

    public static func + (lhs: Self, rhs: Self) -> Self {
        .init(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }

    public static func + (lhs: Self, rhs: CGFloat) -> Self {
        .init(width: lhs.width + rhs, height: lhs.height + rhs)
    }
}

extension CGSize {
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.width -= rhs.width
        lhs.height -= rhs.height
    }

    public static func -= (lhs: inout Self, rhs: CGFloat) {
        lhs = lhs - rhs
    }

    public static func - (lhs: Self, rhs: Self) -> Self {
        .init(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }

    public static func - (lhs: Self, rhs: CGFloat) -> Self {
        .init(width: lhs.width - rhs, height: lhs.height - rhs)
    }
}

extension CGSize {
    public static func *= (lhs: inout Self, rhs: Self) {
        lhs.width *= rhs.width
        lhs.height *= rhs.height
    }

    public static func *= (lhs: inout Self, rhs: CGFloat) {
        lhs = lhs * rhs
    }

    public static func * (lhs: Self, rhs: Self) -> Self {
        .init(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
    }

    public static func * (lhs: Self, rhs: CGFloat) -> Self {
        .init(width: lhs.width * rhs, height: lhs.height * rhs)
    }
}
