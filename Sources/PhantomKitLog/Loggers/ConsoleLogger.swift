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

public class ConsoleLogger {
    public var level: LogLevel
    public var options: Options

    var currentDate: () -> Date = {
        .now
    }

    var log: (String) -> Void = { message in
        #if DEBUG
        print(message)
        #endif
    }

    public init(level: LogLevel = .info, options: Options = .init()) {
        self.level = level
        self.options = options
    }
}

// MARK: - Options

extension ConsoleLogger {
    public struct Options {
        let date: Bool
        let levelIcon: Bool
        let level: Bool
        let categoryIcon: Bool

        public init(
            date: Bool = false,
            levelIcon: Bool = false,
            level: Bool = true,
            categoryIcon: Bool = false
        ) {
            self.date = date
            self.levelIcon = levelIcon
            self.level = level
            self.categoryIcon = categoryIcon
        }
    }
}

// MARK: - Logger

extension ConsoleLogger: Logger {
    public func log(
        level: LogLevel,
        _ message: @autoclosure @escaping () -> String,
        category: LogCategory?
    ) {
        guard level >= self.level else {
            return
        }
        let logString = buildLogString(
            level: level,
            message: message(),
            category: category
        )
        log(logString)
    }
}

// MARK: - Builder

extension ConsoleLogger {
    func buildLogString(
        level: LogLevel,
        message: @autoclosure @escaping () -> String,
        category: LogCategory?
    ) -> String {
        LogBuilder()
            .apply(if: options.date) {
                $0.append(date: currentDate(), options: .tag)
            }
            .apply(if: options.levelIcon) {
                $0.append(string: level.icon)
            }
            .apply(if: options.level) {
                $0.append(string: level.rawValue.uppercased(), options: .tag)
            }
            .apply(if: options.categoryIcon) {
                $0.append(string: category?.icon)
            }
            .append(string: category?.name.capitalized, options: .tag)
            .append(string: message())
            .separate(by: " ")
            .build()
    }
}

// MARK: - Convenience

extension Logger where Self == ConsoleLogger {
    public static var console: Self {
        .init()
    }
}
