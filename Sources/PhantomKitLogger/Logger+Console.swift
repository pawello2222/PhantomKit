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

    public var displayDate = false

    public init(level: LogLevel = .info) {
        self.level = level
    }
}

// MARK: - Logger

extension ConsoleLogger: Logger {
    public func log(
        level: LogLevel,
        _ message: @autoclosure @escaping () -> String,
        category: LogCategory?
    ) {
        #if DEBUG
        guard level >= self.level else {
            return
        }
        let logString = LogBuilder(displayDate: displayDate)
            .append(date: .now, options: .tag)
            .append(string: category?.icon)
            .append(string: category?.name.capitalized, options: .tag)
            .append(string: message())
            .separate(by: " ")
            .build()
        print(logString)
        #endif
    }
}

// MARK: - Convenience

extension Logger where Self == ConsoleLogger {
    public static var console: Self {
        ConsoleLogger()
    }
}
