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

// MARK: - Conformance

extension Array: RawRepresentable where Element: Codable {
    /// Creates a new instance with the specified raw value.
    public init?(rawValue: String) {
        guard
            let data = rawValue.data(using: .utf8),
            let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    /// The corresponding value of the raw type.
    public var rawValue: String {
        guard
            let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

// MARK: Mutations

extension Array where Element: Equatable {
    /// Removes the element if it's present in the array
    /// or appends it otherwise.
    public mutating func toggle(_ element: Element) {
        if let index = firstIndex(where: { $0 == element }) {
            remove(at: index)
        } else {
            append(element)
        }
    }
}

// MARK: - Subscripts

extension Array {
    /// Accesses the element at the specified position in a safe manner
    /// by returning `nil` if the index is out of bounds.
    public subscript(safe index: Int) -> Element? {
        guard 0 ..< count ~= index else {
            return nil
        }
        return self[index]
    }

    /// Accesses a contiguous subrange of the array's elements
    /// in a safe manner by clamping the bounds.
    public subscript(safe bounds: Range<Int>) -> ArraySlice<Element> {
        let lower = bounds.lowerBound.clamped(to: 0 ... count)
        let upper = bounds.upperBound.clamped(to: 0 ... count)
        return self[lower ..< upper]
    }
}
