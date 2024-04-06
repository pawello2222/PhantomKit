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

public enum Loadable<Value> {
    case notRequested
    case isLoading(previous: Value?)
    case loaded(value: Value)
    case failed(error: String)
}

// MARK: - Equatable

extension Loadable: Equatable where Value: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.notRequested, .notRequested):
            return true
        case (.isLoading(let lhsPrevious), .isLoading(let rhsPrevious)):
            return lhsPrevious == rhsPrevious
        case (.loaded(let lhsValue), .loaded(let rhsValue)):
            return lhsValue == rhsValue
        case (.failed(let lhsError), .failed(let rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}

// MARK: - Helpers

extension Loadable {
    public var value: Value? {
        switch self {
        case .loaded(let value):
            return value
        case .isLoading(let previous):
            return previous
        default:
            return nil
        }
    }

    public var error: String? {
        switch self {
        case .failed(let error):
            return error
        default:
            return nil
        }
    }

    public var isLoading: Bool {
        switch self {
        case .isLoading:
            return true
        default:
            return false
        }
    }

    public mutating func setIsLoading() {
        self = .isLoading(previous: value)
    }

    public mutating func cancelLoading() {
        if let value {
            self = .loaded(value: value)
        } else {
            self = .notRequested
        }
    }
}

// MARK: - Map

extension Loadable {
    public func map<T>(_ transform: (Value) -> T) -> Loadable<T> {
        switch self {
        case .notRequested:
            return .notRequested
        case .isLoading(let previous):
            if let previous {
                return .isLoading(previous: transform(previous))
            } else {
                return .isLoading(previous: nil)
            }
        case .loaded(let value):
            return .loaded(value: transform(value))
        case .failed(let error):
            return .failed(error: error)
        }
    }
}
