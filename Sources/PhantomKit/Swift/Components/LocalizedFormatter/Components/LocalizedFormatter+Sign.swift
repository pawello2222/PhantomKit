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
    public struct Sign {
        public let plus: Style
        public let minus: Style
        public let zero: Style

        public init(plus: Style, minus: Style, zero: Style = .none) {
            self.plus = plus
            self.minus = minus
            self.zero = zero
        }
    }
}

// MARK: - Style

extension XFormatter.Sign {
    public enum Style {
        case none
        case localized
        case custom(String)
    }
}

// MARK: - Convenience

extension XFormatter.Sign {
    public static var `default`: Self {
        .init(plus: .none, minus: .localized)
    }

    public static var both: Self {
        .init(plus: .localized, minus: .localized)
    }

    public static var none: Self {
        .init(plus: .none, minus: .none)
    }

    public static var arrow: Self {
        .init(plus: .custom("▲"), minus: .custom("▼"))
    }

    public static var spacedArrow: Self {
        .init(plus: .custom("▲ "), minus: .custom("▼ "))
    }
}
