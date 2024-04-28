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

import Foundation

extension Comparable {
    /// Returns a copy of `self` clamped to the given bounds.
    public func clamped(to bounds: ClosedRange<Self>) -> Self {
        min(max(self, bounds.lowerBound), bounds.upperBound)
    }

    /// Returns a copy of `self` clamped to the given bounds.
    public func clamped(to bounds: PartialRangeFrom<Self>) -> Self {
        max(self, bounds.lowerBound)
    }

    /// Returns a copy of `self` clamped to the given bounds.
    public func clamped(to bounds: PartialRangeThrough<Self>) -> Self {
        min(self, bounds.upperBound)
    }
}

extension Comparable {
    /// Clamps `self` in place to the given bounds.
    public mutating func clamp(to bounds: ClosedRange<Self>) {
        self = clamped(to: bounds)
    }

    /// Clamps `self` in place to the given bounds.
    public mutating func clamp(to bounds: PartialRangeFrom<Self>) {
        self = clamped(to: bounds)
    }

    /// Clamps `self` in place to the given bounds.
    public mutating func clamp(to bounds: PartialRangeThrough<Self>) {
        self = clamped(to: bounds)
    }
}
