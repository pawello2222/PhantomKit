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
