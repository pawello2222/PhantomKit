//
//  APIError.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 07.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case offline
    case network(code: Int, message: String)
    case badRequest(message: String)
    case unauthorized(message: String?)
    case forbidden(message: String?)
    case tooManyRequests(message: String?)
    case recentlyUpdated
    case parsing(message: String)
    case generic(code: Int?, message: String?)
}

// MARK: - Convenience

extension APIError {
    public init(code: Int? = nil, message: String? = nil) {
        self = .generic(code: code, message: message)
    }
}

// MARK: - Computed properties

extension APIError {
    public var message: String? {
        switch self {
        case .network(_, let message),
             .badRequest(let message),
             .parsing(let message):
            return message
        case .unauthorized(let message),
             .forbidden(let message),
             .tooManyRequests(let message),
             .generic(_, let message):
            return message
        default:
            return nil
        }
    }
}

// MARK: - APIErrorMappable

public protocol APIErrorMappable: ResponseDecodable {
    static func parseError(from response: ResponseWrapper) -> APIError
}

public protocol ResponseDecodable {
    associatedtype ResponseWrapper: Decodable
}

public protocol RequestEncodable {
    associatedtype RequestWrapper: Encodable
}
