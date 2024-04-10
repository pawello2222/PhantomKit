// The MIT License (MIT)
//
// Copyright (c) 2023-Present Paweł Wiszenko
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

public protocol Logger {
    var level: LogLevel { get set }

    func log(level: LogLevel, _ message: @autoclosure @escaping () -> String, category: String?)
}

extension Logger {
    public func trace(_ message: @autoclosure @escaping () -> String, category: String) {
        log(level: .trace, message(), category: category)
    }

    public func debug(_ message: @autoclosure @escaping () -> String, category: String) {
        log(level: .debug, message(), category: category)
    }

    public func info(_ message: @autoclosure @escaping () -> String, category: String) {
        log(level: .info, message(), category: category)
    }

    public func notice(_ message: @autoclosure @escaping () -> String, category: String) {
        log(level: .notice, message(), category: category)
    }

    public func warning(_ message: @autoclosure @escaping () -> String, category: String) {
        log(level: .warning, message(), category: category)
    }

    public func error(_ message: @autoclosure @escaping () -> String, category: String) {
        log(level: .error, message(), category: category)
    }

    public func critical(_ message: @autoclosure @escaping () -> String, category: String) {
        log(level: .critical, message(), category: category)
    }
}

// MARK: - LogCategory

public enum LogCategory: String {
    case application
    case presentation
    case domain
    case data
    case persistence
    case network
}

extension LogCategory {
    var icon: String {
        switch self {
        case .application: "⬜"
        case .presentation: "🟦"
        case .domain: "🟩"
        case .data: "🟥"
        case .persistence: "🟫"
        case .network: "🟨"
        }
    }
}

extension Logger {
    public func log(level: LogLevel, _ message: @autoclosure @escaping () -> String, category: LogCategory) {
        log(level: level, message(), category: category.rawValue)
    }

    public func trace(_ message: @autoclosure @escaping () -> String, category: LogCategory) {
        log(level: .trace, message(), category: category)
    }

    public func debug(_ message: @autoclosure @escaping () -> String, category: LogCategory) {
        log(level: .debug, message(), category: category)
    }

    public func info(_ message: @autoclosure @escaping () -> String, category: LogCategory) {
        log(level: .info, message(), category: category)
    }

    public func notice(_ message: @autoclosure @escaping () -> String, category: LogCategory) {
        log(level: .notice, message(), category: category)
    }

    public func warning(_ message: @autoclosure @escaping () -> String, category: LogCategory) {
        log(level: .warning, message(), category: category)
    }

    public func error(_ message: @autoclosure @escaping () -> String, category: LogCategory) {
        log(level: .error, message(), category: category)
    }

    public func critical(_ message: @autoclosure @escaping () -> String, category: LogCategory) {
        log(level: .critical, message(), category: category)
    }
}

// MARK: - LogLevel

public enum LogLevel: String, CaseIterable {
    case trace
    case debug
    case info
    case notice
    case warning
    case error
    case critical
}

extension LogLevel {
    var icon: String {
        switch self {
        case .trace: "⬜"
        case .debug: "🟫"
        case .info: "🟦"
        case .notice: "🟩"
        case .warning: "🟨"
        case .error: "🟥"
        case .critical: "🟪"
        }
    }
}

extension LogLevel: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.orderValue < rhs.orderValue
    }

    private var orderValue: Int {
        Self.allCases.firstIndex(of: self)!
    }
}
