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

import SwiftUI

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
