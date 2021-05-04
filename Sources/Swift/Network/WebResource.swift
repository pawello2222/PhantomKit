//
//  WebResource.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 28.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

public protocol WebResource {
    associatedtype Response: Decodable

    var httpMethod: String { get }
    var serverPath: String { get }
    var methodPath: String { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension WebResource {
    public var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = serverPath
        components.path = methodPath
        components.queryItems = queryItems
        return components.url
    }
}
