//
//  APIEndpoint.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import Foundation

public protocol APIEndpoint {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}

extension APIEndpoint {
    public func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        return try URLRequest(url: url).applying {
            $0.httpMethod = method
            $0.allHTTPHeaderFields = headers
            $0.httpBody = try body()
        }
    }
}
