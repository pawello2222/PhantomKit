// The MIT License (MIT)
//
// Copyright (c) 2021-Present Paweł Wiszenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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

// MARK: - Convenience

extension CGSize {
    /// Creates a new instance by assigning `length` to both width and height.
    public init(length: CGFloat) {
        self = CGSize(width: length, height: length)
    }
}

// MARK: - Operators

extension CGSize {
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
