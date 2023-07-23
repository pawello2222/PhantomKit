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

extension LocalizedFormatter {
    public struct Abbreviation {
        public let thresholds: [Threshold]

        public init(_ thresholds: [Threshold] = []) {
            self.thresholds = thresholds
                .sorted {
                    $0.value > $1.value
                }
        }
    }
}

// MARK: - Computed Properties

extension LocalizedFormatter.Abbreviation {
    public var capitalized: Self {
        .init(
            thresholds.map {
                .init(suffix: $0.suffix.capitalized, value: $0.value)
            }
        )
    }
}

// MARK: - Convenience

extension LocalizedFormatter.Abbreviation {
    public static var `default`: Self = .init(
        [
            .init(suffix: "m", value: 1_000_000),
            .init(suffix: "k", value: 1000)
        ]
    )

    public static var none: Self = .init()

    public static var capitalized = Self.default.capitalized
}
