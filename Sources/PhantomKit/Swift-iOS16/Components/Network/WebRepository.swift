//
//  WebRepository.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 06/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import Foundation

public protocol WebRepository {
    associatedtype Endpoint: APIEndpoint

    var session: URLSession { get }
}

extension WebRepository {
    public func call(
        endpoint: Endpoint,
        httpCodes: HTTPCodes = .success
    ) async throws -> Data {
        let request = try endpoint.urlRequest()
        let (data, response) = try await session.data(for: request)
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            Logger.debug(response.description, category: .network)
            throw APIError.unexpectedResponse
        }
        guard httpCodes.contains(code) else {
            Logger.debug(response.description, category: .network)
            throw APIError.httpCode(code)
        }
        return data
    }

    public func call<Response>(
        endpoint: Endpoint,
        httpCodes: HTTPCodes = .success,
        decoding type: Response.Type
    ) async throws -> Response where Response: Decodable {
        let data = try await call(endpoint: endpoint, httpCodes: httpCodes)
        return try JSONDecoder().decode(Response.self, from: data)
    }
}

// MARK: - Mock

public protocol MockWebRepository: WebRepository where Endpoint == MockEndpoint {
    var fileManager: FileManager { get }
}

extension MockWebRepository {
    public func mockCall(filename: String, in bundle: Bundle) async throws -> Data {
        try fileManager.loadData(filename: filename, in: bundle)
    }

    public func mockCall<Response>(
        filename: String,
        in bundle: Bundle,
        decoding type: Response.Type
    ) async throws -> Response where Response: Decodable {
        let data = try await mockCall(filename: filename, in: bundle)
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
