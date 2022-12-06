//
//  APIError.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .httpCode(let code):
            return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse:
            return "Unexpected response from the server"
        }
    }
}

public typealias HTTPCode = Int
public typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    public static let success = 200 ..< 300
}
