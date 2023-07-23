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

extension XFormatter {
    public struct Precision {
        public let minimum: Int?
        public let maximum: Int?
    }
}

// MARK: - Initialization

extension XFormatter.Precision {
    public init() {
        minimum = nil
        maximum = nil
    }

    public init(_ range: PartialRangeFrom<Int>) {
        minimum = Self.clamp(range.lowerBound)
        maximum = nil
    }

    public init(_ range: PartialRangeThrough<Int>) {
        minimum = nil
        maximum = Self.clamp(range.upperBound)
    }

    public init(_ range: ClosedRange<Int>) {
        minimum = Self.clamp(range.lowerBound)
        maximum = Self.clamp(range.upperBound)
    }

    private static func clamp(_ value: Int) -> Int {
        value.clamped(to: .zero ... .max)
    }
}

// MARK: - Convenience

extension XFormatter.Precision {
    public static var `default`: Self {
        .init(...2)
    }

    public static var maximum: Self {
        .init(...16)
    }

    public static func constant(_ value: Int) -> Self {
        .init(value ... value)
    }
}
