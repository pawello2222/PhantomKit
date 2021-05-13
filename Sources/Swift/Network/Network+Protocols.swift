//
//  Network+Protocols.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 13.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

public protocol RequestEncodable {
    associatedtype RequestWrapper: Encodable
}

public protocol ResponseDecodable {
    associatedtype ResponseWrapper: Decodable
}

// MARK: - APIErrorMappable

public protocol APIErrorMappable: ResponseDecodable {
    static func parseError(from response: ResponseWrapper) -> APIError
}
