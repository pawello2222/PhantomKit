//
//  WebRepository.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 06/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import Foundation

public protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
}

// MARK: - Async

extension WebRepository {
    public func call(
        endpoint: APIEndpoint,
        httpCodes: HTTPCodes = .success
    ) async throws -> Data {
        let request = try endpoint.urlRequest(baseURL: baseURL)
        let result = try await session.data(for: request)
        guard let code = (result.1 as? HTTPURLResponse)?.statusCode else {
            throw APIError.unexpectedResponse
        }
        guard httpCodes.contains(code) else {
            throw APIError.httpCode(code)
        }
        return result.0
    }

    public func decode<Value>(data: Data) throws -> Value where Value: Decodable {
        try JSONDecoder().decode(Value.self, from: data)
    }
}
