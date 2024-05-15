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
import OSLog

public class OSLogLogger {
    private typealias InternalLogger = os.Logger

    private var subsystem: String
    private var loggers: [String: InternalLogger] = [:]

    public var level: LogLevel

    public init(level: LogLevel = .info, subsystem: String? = nil) {
        self.level = level
        self.subsystem = subsystem ?? Bundle.main.bundleIdentifier ?? ""
    }
}

// MARK: - Logger

extension OSLogLogger: Logger {
    public func log(
        level: LogLevel,
        _ message: @autoclosure @escaping () -> String,
        category: LogCategory?
    ) {
        #if DEBUG
        guard level >= self.level else {
            return
        }
        let category = category?.name.capitalized ?? "Default"
        let level = level.osLogType
        logger(for: category).log(level: level, "\(message(), privacy: .private)")
        #endif
    }
}

// MARK: - Helpers

extension OSLogLogger {
    private func logger(for category: String) -> InternalLogger {
        loggers[category, default: .init(subsystem: subsystem, category: category)]
    }
}

// MARK: - Convenience

extension Logger where Self == OSLogLogger {
    public static var osLog: Self {
        .init()
    }
}

// MARK: - OSLogType

extension LogLevel {
    fileprivate var osLogType: OSLogType {
        switch self {
        case .trace, .debug:
            .debug
        case .info:
            .info
        case .notice:
            .default
        case .warning, .error:
            .error
        case .critical:
            .fault
        }
    }
}
