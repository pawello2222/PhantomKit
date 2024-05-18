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

class NetworkDataSourceTests: XCTestCase {
    override func setUpWithError() throws {}
}

// MARK: - Tests: Common

extension NetworkDataSourceTests {
    func test_call_returnHTTPResponseSuccessCode() async throws {
        let session = NetworkSessionSpy()
        session.result = .success(.http(code: 200))
        let dataSource = TestDataSource(session: session)
        let result = try? await dataSource.call(request: .test)
        XCTAssertNotNil(result)
    }

    func test_call_returnHTTPResponseErrorCode() async throws {
        let session = NetworkSessionSpy()
        session.result = .success(.http(code: 500))
        let dataSource = TestDataSource(session: session)
        do {
            _ = try await dataSource.call(request: .test)
        } catch let error as APIError {
            XCTAssertEqual(error, .httpCode(500, message: nil))
            return
        }
        XCTFail()
    }

    func test_call_returnUnexpectedResponse() async throws {
        let session = NetworkSessionSpy()
        session.result = .success(.any)
        let dataSource = TestDataSource(session: session)
        do {
            _ = try await dataSource.call(request: .test)
        } catch let error as APIError {
            XCTAssertEqual(error, .unexpectedResponse(.any))
            return
        }
        XCTFail()
    }

    func test_call_throwConnectionError() async throws {
        let session = NetworkSessionSpy()
        session.result = .failure(URLError(.notConnectedToInternet))
        let dataSource = TestDataSource(session: session)
        do {
            _ = try await dataSource.call(request: .test)
        } catch let error as APIError {
            XCTAssertEqual(error, .connectionError)
            return
        }
        XCTFail()
    }

    func test_call_throwAnyError() async throws {
        let session = NetworkSessionSpy()
        session.result = .failure(URLError(.cancelled))
        let dataSource = TestDataSource(session: session)
        do {
            _ = try await dataSource.call(request: .test)
        } catch let error as URLError {
            XCTAssertEqual(error.code, .cancelled)
            return
        }
        XCTFail()
    }
}
