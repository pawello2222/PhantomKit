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

// MARK: - Operators

/// Creates a binding by unwrapping a given value and providing a default value.
public func ?? <T>(lhs: Binding<T?>, rhs: T) -> Binding<T> {
    .init(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

// MARK: - Transform

extension Binding {
    /// Converts the `wrappedValue` from `BinaryInteger` to `BinaryFloatingPoint`.
    public static func convert<TInt, TFloat>(
        from binding: Binding<TInt>
    ) -> Binding<TFloat> where TInt: BinaryInteger, TFloat: BinaryFloatingPoint {
        Binding<TFloat>(
            get: { TFloat(binding.wrappedValue) },
            set: { binding.wrappedValue = TInt($0) }
        )
    }

    /// Converts the `wrappedValue` from `BinaryFloatingPoint` to `BinaryInteger`.
    public static func convert<TFloat, TInt>(
        from binding: Binding<TFloat>
    ) -> Binding<TInt> where TFloat: BinaryFloatingPoint, TInt: BinaryInteger {
        Binding<TInt>(
            get: { TInt(binding.wrappedValue) },
            set: { binding.wrappedValue = TFloat($0) }
        )
    }
}
