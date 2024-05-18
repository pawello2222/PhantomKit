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

class OSLogLoggerTests: XCTestCase {
    override func setUpWithError() throws {}
}

// MARK: - Tests: Logger

extension OSLogLoggerTests {
    func test_log_aboveLevel() throws {
        var result: String?
        let logger = OSLogLogger()
        logger.level = .info
        logger.log = { _, message, _ in
            result = message
        }
        logger.log(
            level: .info,
            "Test message",
            category: nil
        )
        XCTAssertEqual(result, "Test message")
    }

    func test_log_belowLevel() throws {
        var result: String?
        let logger = OSLogLogger()
        logger.level = .error
        logger.log = { _, message, _ in
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

// MARK: - Tests: OSLogType

extension OSLogLoggerTests {
    func test_osLogType() throws {
        XCTAssertEqual(LogLevel.trace.osLogType, .debug)
        XCTAssertEqual(LogLevel.debug.osLogType, .debug)
        XCTAssertEqual(LogLevel.info.osLogType, .info)
        XCTAssertEqual(LogLevel.warning.osLogType, .error)
        XCTAssertEqual(LogLevel.error.osLogType, .error)
        XCTAssertEqual(LogLevel.critical.osLogType, .fault)
    }
}
