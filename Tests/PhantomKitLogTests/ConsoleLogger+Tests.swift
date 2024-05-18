// The MIT License (MIT)
//
// Copyright (c) 2024-Present Paweł Wiszenko
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

import Appliable
import PhantomKitCore
import XCTest
@testable import PhantomKitLog

class ConsoleLoggerTests: XCTestCase {
    override func setUpWithError() throws {}
}

// MARK: - Tests: Logger

extension ConsoleLoggerTests {
    func test_log_aboveLevel() throws {
        var result: String?
        let logger = ConsoleLogger()
        logger.level = .info
        logger.log = { message in
            result = message
        }
        logger.log(
            level: .info,
            "Test message",
            category: nil
        )
        XCTAssertEqual(result, "[INFO] Test message")
    }

    func test_log_belowLevel() throws {
        var result: String?
        let logger = ConsoleLogger()
        logger.level = .error
        logger.log = { message in
            result = message
        }
        logger.log(
            level: .info,
            "Test message",
            category: nil
        )
        XCTAssertNil(result)
    }
}

// MARK: - Tests: Builder

extension ConsoleLoggerTests {
    func test_buildLogString_noCategory_defaultOptions() throws {
        let logger = ConsoleLogger()
        let result = logger.buildLogString(
            level: .info,
            message: "Test message",
            category: nil
        )
        XCTAssertEqual(result, "[INFO] Test message")
    }

    func test_buildLogString_noCategory_optionsNoLevel() throws {
        let logger = ConsoleLogger(options: .init(level: false))
        let result = logger.buildLogString(
            level: .info,
            message: "Test message",
            category: nil
        )
        XCTAssertEqual(result, "Test message")
    }

    func test_buildLogString_defaultCategory_defaultOptions() throws {
        let logger = ConsoleLogger()
        let result = logger.buildLogString(
            level: .info,
            message: "Test message",
            category: DefaultLogCategory.default
        )
        XCTAssertEqual(result, "[INFO] [Default] Test message")
    }

    func test_buildLogString_defaultCategory_optionsDate() throws {
        let date = Date(year: 2000, month: 1, day: 2, hour: 3, minute: 4, second: 5)
        let logger = ConsoleLogger(options: .init(date: true))
        logger.currentDate = { date }

        let result = logger.buildLogString(
            level: .info,
            message: "Test message",
            category: DefaultLogCategory.default
        )
        XCTAssertEqual(result, "[\(Self.dateFormatter.string(from: date))] [INFO] [Default] Test message")
    }

    func test_buildLogString_defaultCategory_optionsCategoryIcon() throws {
        let logger = ConsoleLogger(options: .init(categoryIcon: true))
        let result = logger.buildLogString(
            level: .info,
            message: "Test message",
            category: DefaultLogCategory.default
        )
        XCTAssertEqual(result, "[INFO] ⚪ [Default] Test message")
    }

    func test_buildLogString_defaultCategory_optionsLevelIcon() throws {
        let logger = ConsoleLogger(options: .init(levelIcon: true))
        let result = logger.buildLogString(
            level: .info,
            message: "Test message",
            category: DefaultLogCategory.default
        )
        XCTAssertEqual(result, "🟩 [INFO] [Default] Test message")
    }

    func test_buildLogString_defaultCategory_optionsAll() throws {
        let date = Date(year: 2000, month: 1, day: 2, hour: 3, minute: 4, second: 5)
        let logger = ConsoleLogger(options: .init(date: true, levelIcon: true, level: true, categoryIcon: true))
        logger.currentDate = { date }

        let result = logger.buildLogString(
            level: .info,
            message: "Test message",
            category: DefaultLogCategory.default
        )
        XCTAssertEqual(result, "[\(Self.dateFormatter.string(from: date))] 🟩 [INFO] ⚪ [Default] Test message")
    }
}

// MARK: - Private

extension ConsoleLoggerTests {
    private static var dateFormatter = DateFormatter().apply {
        $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    }
}
