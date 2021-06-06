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

// MARK: - Convenience

extension APIError {
    public init(code: Int? = nil, message: String? = nil) {
        self = .generic(code: code, message: message)
    }
}

extension APIError {
    public var isBadRequest: Bool {
        guard case .badRequest = self else {
            return false
        }
        return true
    }

    public var isUnauthorized: Bool {
        guard case .unauthorized = self else {
            return false
        }
        return true
    }

    public var isForbidden: Bool {
        guard case .forbidden = self else {
            return false
        }
        return true
    }

    public var isTooManyRequests: Bool {
        guard case .tooManyRequests = self else {
            return false
        }
        return true
    }

    public var isParsing: Bool {
        guard case .parsing = self else {
            return false
        }
        return true
    }
}
