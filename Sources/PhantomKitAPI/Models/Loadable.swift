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
    case loading(previous: Value?)
    case loaded(value: Value)
    case failed(error: String?)
}

// MARK: - Conformance

extension Loadable: Equatable where Value: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.notRequested, .notRequested):
            true
        case (.loading(let lhsPrevious), .loading(let rhsPrevious)):
            lhsPrevious == rhsPrevious
        case (.loaded(let lhsValue), .loaded(let rhsValue)):
            lhsValue == rhsValue
        case (.failed(let lhsError), .failed(let rhsError)):
            lhsError == rhsError
        default:
            false
        }
    }
}

// MARK: - Helpers

extension Loadable {
    public var value: Value? {
        switch self {
        case .loaded(let value):
            value
        case .loading(let previous):
            previous
        default:
            nil
        }
    }

    public var error: String? {
        switch self {
        case .failed(let error):
            error
        default:
            nil
        }
    }

    public var isLoading: Bool {
        switch self {
        case .loading:
            true
        default:
            false
        }
    }

    public var isFailed: Bool {
        switch self {
        case .failed:
            true
        default:
            false
        }
    }
}

// MARK: - Mutation

extension Loadable {
    public mutating func startLoading() {
        self = .loading(previous: value)
    }

    public mutating func cancelLoading() {
        if let value {
            self = .loaded(value: value)
        } else {
            self = .notRequested
        }
    }
}

// MARK: - Transform

extension Loadable {
    public func mapValue<T>(_ transform: (Value) -> T) -> Loadable<T> {
        switch self {
        case .notRequested:
            .notRequested
        case .loading(let previous):
            if let previous {
                .loading(previous: transform(previous))
            } else {
                .loading(previous: nil)
            }
        case .loaded(let value):
            .loaded(value: transform(value))
        case .failed(let error):
            .failed(error: error)
        }
    }
}
