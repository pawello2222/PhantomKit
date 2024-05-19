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

import XCTest
@testable import PhantomKitAPI

class LoadableTests: XCTestCase {
    override func setUpWithError() throws {}
}

// MARK: - Tests: Conformance

extension LoadableTests {
    func test_equality() throws {
        XCTAssertEqual(Loadable<Int>.notRequested, .notRequested)
        XCTAssertEqual(Loadable<Int>.loading(previous: 1), .loading(previous: 1))
        XCTAssertNotEqual(Loadable<Int>.loading(previous: 1), .loading(previous: 2))
        XCTAssertNotEqual(Loadable<Int>.loading(previous: 1), .loading(previous: nil))
        XCTAssertEqual(Loadable<Int>.loaded(value: 1), .loaded(value: 1))
        XCTAssertNotEqual(Loadable<Int>.loaded(value: 1), .loaded(value: 2))
        XCTAssertEqual(Loadable<Int>.failed(error: "1"), .failed(error: "1"))
        XCTAssertNotEqual(Loadable<Int>.failed(error: "1"), .failed(error: "2"))
        XCTAssertNotEqual(Loadable<Int>.notRequested, .loading(previous: 1))
    }
}

// MARK: - Tests: Helpers

extension LoadableTests {
    func test_value() throws {
        XCTAssertEqual(Loadable<Int>.notRequested.value, nil)
        XCTAssertEqual(Loadable<Int>.loading(previous: nil).value, nil)
        XCTAssertEqual(Loadable<Int>.loading(previous: 1).value, 1)
        XCTAssertEqual(Loadable<Int>.loaded(value: 1).value, 1)
        XCTAssertEqual(Loadable<Int>.failed(error: "1").value, nil)
    }

    func test_error() throws {
        XCTAssertEqual(Loadable<Int>.notRequested.error, nil)
        XCTAssertEqual(Loadable<Int>.loading(previous: nil).error, nil)
        XCTAssertEqual(Loadable<Int>.loading(previous: 1).error, nil)
        XCTAssertEqual(Loadable<Int>.loaded(value: 1).error, nil)
        XCTAssertEqual(Loadable<Int>.failed(error: "1").error, "1")
    }

    func test_isLoading() throws {
        XCTAssertFalse(Loadable<Int>.notRequested.isLoading)
        XCTAssertTrue(Loadable<Int>.loading(previous: nil).isLoading)
        XCTAssertTrue(Loadable<Int>.loading(previous: 1).isLoading)
        XCTAssertFalse(Loadable<Int>.loaded(value: 1).isLoading)
        XCTAssertFalse(Loadable<Int>.failed(error: "1").isLoading)
    }

    func test_isFailed() throws {
        XCTAssertFalse(Loadable<Int>.notRequested.isFailed)
        XCTAssertFalse(Loadable<Int>.loading(previous: nil).isFailed)
        XCTAssertFalse(Loadable<Int>.loading(previous: 1).isFailed)
        XCTAssertFalse(Loadable<Int>.loaded(value: 1).isFailed)
        XCTAssertTrue(Loadable<Int>.failed(error: "1").isFailed)
    }
}

// MARK: - Tests: Mutation

extension LoadableTests {
    func test_startLoadingWhenNotLoading() throws {
        var loadable = Loadable<Int>.notRequested
        XCTAssertFalse(loadable.isLoading)

        loadable.startLoading()

        XCTAssertTrue(loadable.isLoading)
        XCTAssertEqual(loadable, .loading(previous: nil))
    }

    func test_startLoadingWhenIsLoading() throws {
        var loadable = Loadable<Int>.loading(previous: nil)
        XCTAssertTrue(loadable.isLoading)

        loadable.startLoading()

        XCTAssertTrue(loadable.isLoading)
        XCTAssertEqual(loadable, .loading(previous: nil))
    }

    func test_cancelLoadingWithoutPreviousValue() throws {
        var loadable = Loadable<Int>.loading(previous: nil)
        XCTAssertTrue(loadable.isLoading)

        loadable.cancelLoading()

        XCTAssertFalse(loadable.isLoading)
        XCTAssertEqual(loadable, .notRequested)
    }

    func test_cancelLoadingWithPreviousValue() throws {
        let value = 1
        var loadable = Loadable<Int>.loading(previous: value)
        XCTAssertTrue(loadable.isLoading)

        loadable.cancelLoading()

        XCTAssertFalse(loadable.isLoading)
        XCTAssertEqual(loadable, .loaded(value: value))
    }
}

// MARK: - Tests: Transform

extension LoadableTests {
    func test_mapValue() throws {
        let name = "Test"
        let error = "Error"
        XCTAssertEqual(
            Loadable<Item>.notRequested.mapValue(\.name),
            .notRequested
        )
        XCTAssertEqual(
            Loadable<Item>.loading(previous: nil).mapValue(\.name),
            .loading(previous: nil)
        )
        XCTAssertEqual(
            Loadable<Item>.loading(previous: Item(name: name)).mapValue(\.name),
            .loading(previous: name)
        )
        XCTAssertEqual(
            Loadable<Item>.loaded(value: Item(name: name)).mapValue(\.name),
            .loaded(value: name)
        )
        XCTAssertEqual(
            Loadable<Item>.failed(error: error).mapValue(\.name),
            .failed(error: error)
        )
    }
}

// MARK: - Private

private struct Item {
    let name: String
}
