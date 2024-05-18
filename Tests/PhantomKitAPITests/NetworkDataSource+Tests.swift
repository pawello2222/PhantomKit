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

import PhantomKitLog
import XCTest
@testable import PhantomKitAPI

class NetworkDataSourceTests: XCTestCase {
    override func setUpWithError() throws {}
}

// MARK: - Tests: Common

extension NetworkDataSourceTests {
    func test_call_responseCorrectCode() async throws {
        let session = NetworkSessionSpy()
        session.data = .init()
        session.response = .http(code: 200)
        let dataSource = CustomDataSource(session: session)
        let result = try? await dataSource.call(request: .test)
        XCTAssertNotNil(result)
    }
}

// MARK: - Private

private class CustomDataSource: NetworkDataSource {
    var session: NetworkSession
    var logger: Logger?

    init(session: NetworkSession, logger: Logger? = nil) {
        self.session = session
        self.logger = logger
    }
}

private class NetworkSessionSpy: NetworkSession {
    var data: Data!
    var response: URLResponse!
    var error: Error!

    func data(
        for urlRequest: URLRequest,
        delegate: URLSessionTaskDelegate?
    ) async throws -> (Data, URLResponse) {
        if let error {
            throw error
        }
        return (data, response)
    }
}

extension URL {
    fileprivate static let test: Self = .init(string: "https://example.com")!
}

extension URLRequest {
    fileprivate static let test: Self = .init(url: .test)
}

extension URLResponse {
    fileprivate static let any: URLResponse = .init(
        url: .test,
        mimeType: nil,
        expectedContentLength: 0,
        textEncodingName: nil
    )

    fileprivate static func http(code: Int) -> URLResponse {
        HTTPURLResponse(
            url: .test,
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
    }
}
