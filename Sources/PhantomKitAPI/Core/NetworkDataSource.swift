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
import PhantomKitCore
import PhantomKitLog

public protocol NetworkDataSource {
    var session: NetworkSession { get }
    var logger: Logger? { get }
}

// MARK: - Common

extension NetworkDataSource {
    public func call(
        request: URLRequest,
        allowedHTTPCodes: HTTPCodes = .success
    ) async throws -> Data {
        do {
            log(request: request)
            let (data, response) = try await session.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw APIError.unexpectedResponse(response)
            }
            log(request: request, response: response, data: data)
            guard allowedHTTPCodes ~= response.statusCode else {
                throw APIError.httpCode(response.statusCode, message: nil)
            }
            return data
        } catch let error as URLError {
            throw try map(error: error)
        }
    }

    private func map(error: URLError) throws -> Error {
        guard error.code.isConnectionError else {
            return error
        }
        return APIError.connectionError
    }
}

// MARK: - Logger

extension NetworkDataSource {
    private func log(request: URLRequest) {
        guard let logger else {
            return
        }
        let httpMethod = request.httpMethod ?? "?"
        logger.debug(
            "[\(httpMethod)] --> \(request)",
            category: DefaultLogCategory.default
        )
    }

    private func log(request: URLRequest, response: HTTPURLResponse, data: Data) {
        guard let logger else {
            return
        }
        let httpMethod = request.httpMethod ?? "?"
        let body = String(data: data, encoding: .utf8) ?? ""
        logger.debug(
            "[\(httpMethod)] \(response.statusCode) \(request)\n\(body)",
            category: DefaultLogCategory.default
        )
    }
}

// MARK: - URLError.Code

extension URLError.Code {
    fileprivate var isConnectionError: Bool {
        isContained(
            in: [
                .cannotConnectToHost,
                .cannotFindHost,
                .cannotLoadFromNetwork,
                .internationalRoamingOff,
                .networkConnectionLost,
                .notConnectedToInternet,
                .secureConnectionFailed,
                .timedOut
            ]
        )
    }
}
