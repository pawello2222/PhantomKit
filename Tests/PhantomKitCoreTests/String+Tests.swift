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

import XCTest
@testable import PhantomKitCore

class StringTests: XCTestCase {
    override func setUpWithError() throws {}
}

// MARK: - Tests: Helpers

extension StringTests {
    func test_capitalizedFirst() throws {
        XCTAssertEqual("123".capitalizedFirst, "123")
        XCTAssertEqual("asd".capitalizedFirst, "Asd")
        XCTAssertEqual("asD".capitalizedFirst, "AsD")
        XCTAssertEqual("".capitalizedFirst, "")
        XCTAssertEqual("@aa".capitalizedFirst, "@aa")
    }

    func test_isHexNumber() throws {
        XCTAssertTrue("123".isHexNumber)
        XCTAssertTrue("aa32".isHexNumber)
        XCTAssertTrue("AD1".isHexNumber)
        XCTAssertFalse("FFG".isHexNumber)
        XCTAssertFalse("text1".isHexNumber)
    }

    func test_urlEscaped() throws {
        XCTAssertEqual("123".urlEscaped(), "123")
        XCTAssertEqual("!@$&*()_-+=;:'~".urlEscaped(), "!@$&*()_-+=;:'~")
        XCTAssertEqual("\"#%<>[\\]^`{|}".urlEscaped(), "%22%23%25%3C%3E%5B%5C%5D%5E%60%7B%7C%7D")
    }
}

// MARK: - Tests: NSString

extension StringTests {
    func test_lastPathComponent() throws {
        XCTAssertEqual("/tmp/lock.tiff".lastPathComponent, "lock.tiff")
        XCTAssertEqual("/tmp/lock".lastPathComponent, "lock")
        XCTAssertEqual("/tmp/".lastPathComponent, "tmp")
        XCTAssertEqual("lock///".lastPathComponent, "lock")
        XCTAssertEqual("/".lastPathComponent, "/")
    }

    func test_deletingLastPathComponent() throws {
        XCTAssertEqual("/tmp/lock.tiff".deletingLastPathComponent, "/tmp")
        XCTAssertEqual("/tmp/lock/".deletingLastPathComponent, "/tmp")
        XCTAssertEqual("/tmp/".deletingLastPathComponent, "/")
        XCTAssertEqual("/tmp".deletingLastPathComponent, "/")
        XCTAssertEqual("/".deletingLastPathComponent, "/")
        XCTAssertEqual("lock.tiff".deletingLastPathComponent, "")
    }

    func test_deletingPathExtension() throws {
        XCTAssertEqual("/tmp/lock.tiff".deletingPathExtension, "/tmp/lock")
        XCTAssertEqual("/tmp/".deletingPathExtension, "/tmp")
        XCTAssertEqual("lock.bundle/".deletingPathExtension, "lock")
        XCTAssertEqual("lock..tiff".deletingPathExtension, "lock.")
        XCTAssertEqual(".tiff".deletingPathExtension, ".tiff")
        XCTAssertEqual("/".deletingPathExtension, "/")
    }

    func test_pathExtension() throws {
        XCTAssertEqual("/tmp/lock.tiff".pathExtension, "tiff")
        XCTAssertEqual(".lock.tiff".pathExtension, "tiff")
        XCTAssertEqual("/tmp/lock".pathExtension, "")
        XCTAssertEqual("/tmp/".pathExtension, "")
        XCTAssertEqual("/tmp/lock..tiff".pathExtension, "tiff")
    }

    func test_appendingPathComponent() throws {
        XCTAssertEqual("/tmp/".appendingPathComponent("lock.tiff"), "/tmp/lock.tiff")
        XCTAssertEqual("tmp".appendingPathComponent("lock.tiff"), "tmp/lock.tiff")
        XCTAssertEqual("lock.bundle".appendingPathComponent("lock"), "lock.bundle/lock")
        XCTAssertEqual("tmp/".appendingPathComponent("/lock..tiff"), "tmp/lock..tiff")
        XCTAssertEqual(".".appendingPathComponent("."), "./.")
        XCTAssertEqual("/".appendingPathComponent("/lock"), "/lock")
        XCTAssertEqual("/".appendingPathComponent(nil), "/")
    }
}
