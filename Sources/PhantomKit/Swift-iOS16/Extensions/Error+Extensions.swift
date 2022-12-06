//
//  Error+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Error {
    public var nsError: NSError {
        self as NSError
    }

    public var underlyingError: Error? {
//        if nsError.domain == NSURLErrorDomain && nsError.code == -1009 {
//            // "The Internet connection appears to be offline."
//            return self
//        }
        nsError.userInfo[NSUnderlyingErrorKey] as? Error
    }

    public var description: String {
        nsError.description
    }
}

// MARK: - Blocks

public func withErrorLogging<Result>(
    category: Logger.Category = .default,
    _ body: () throws -> Result
) rethrows -> Result {
    do {
        return try body()
    } catch {
        Logger.error(error.description, category: category)
        throw error
    }
}

public func withErrorLogging<Result>(
    category: Logger.Category = .default,
    _ body: () async throws -> Result
) async rethrows -> Result {
    do {
        return try await body()
    } catch {
        Logger.error(error.description, category: category)
        throw error
    }
}
