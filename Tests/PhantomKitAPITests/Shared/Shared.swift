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

import Foundation
import PhantomKitAPI
import PhantomKitLog

// MARK: - Convenience

extension Data {
    static let test: Self = "Test".data(using: .utf8)!
}

extension [String: String]? {
    static let test: Self = ["Accept": "application/json"]
}

extension URL {
    static let test: Self = .init(string: "https://example.com")!
}

extension URLRequest {
    static let test: Self = .init(url: .test)
}

extension URLResponse {
    static let any: URLResponse = .init(
        url: .test,
        mimeType: nil,
        expectedContentLength: 0,
        textEncodingName: nil
    )

    static func http(code: Int) -> URLResponse {
        HTTPURLResponse(
            url: .test,
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
    }
}

// MARK: - Mocks

class NetworkSessionStub: NetworkSession {
    var result: Result<(Data, URLResponse), Error> = .success((.test, .http(code: 200)))

    func data(
        for urlRequest: URLRequest,
        delegate: URLSessionTaskDelegate?
    ) async throws -> (Data, URLResponse) {
        try result.get()
    }
}

// MARK: - Shared

struct TestAPIEndpoint: APIEndpoint {
    var baseURL: String
    var path: String
    var method: APIMethod
    var headers: [String: String]?

    func body() throws -> Data? {
        .test
    }
}

extension TestAPIEndpoint {
    static let test = TestAPIEndpoint(
        baseURL: "https://api.example.com",
        path: "test",
        method: .get
    )
}

class TestDataSource: NetworkDataSource {
    var session: NetworkSession
    var logger: Logger?

    init(session: NetworkSession, logger: Logger? = nil) {
        self.session = session
        self.logger = logger
    }
}

extension TestDataSource: APIDataSource {
    typealias Endpoint = TestAPIEndpoint
}

class TestLogger: Logger {
    var messages: [String] = []
    var level: LogLevel = .debug

    func log(
        level: LogLevel,
        _ message: @autoclosure @escaping () -> String,
        category: LogCategory?
    ) {
        messages.append(message())
    }
}
