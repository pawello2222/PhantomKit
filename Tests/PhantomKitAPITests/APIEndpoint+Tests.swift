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

class APIEndpointTests: XCTestCase {
    override func setUpWithError() throws {}
}

// MARK: - Tests: Common

extension APIEndpointTests {
    func test_urlRequest() throws {
        let endpoint: APIEndpoint = CustomAPIEndpoint(
            baseURL: "https://api.example.com",
            path: "test",
            method: .get,
            headers: .acceptJson
        )

        let request = try endpoint.urlRequest()

        XCTAssertEqual(request.url?.absoluteString, "https://api.example.com/test")
        XCTAssertEqual(request.httpMethod, APIMethod.get.rawValue)
        XCTAssertEqual(request.allHTTPHeaderFields, .acceptJson)
        XCTAssertEqual(request.httpBody, .test)
    }

    func test_urlRequest_invalidURL() throws {
        let endpoint: APIEndpoint = CustomAPIEndpoint(
            baseURL: "$xyz://api.example.com",
            path: "test",
            method: .get
        )

        XCTAssertThrowsError(try endpoint.urlRequest()) { error in
            XCTAssertEqual(error as? APIError, APIError.invalidURL)
        }
    }
}

// MARK: - Private

private struct CustomAPIEndpoint: APIEndpoint {
    var baseURL: String
    var path: String
    var method: APIMethod
    var headers: [String: String]?

    func body() throws -> Data? {
        .test
    }
}

// MARK: - Convenience

extension Data {
    fileprivate static let test: Self = "Test".data(using: .utf8)!
}

extension [String: String]? {
    fileprivate static let acceptJson: Self = ["Accept": "application/json"]
}
