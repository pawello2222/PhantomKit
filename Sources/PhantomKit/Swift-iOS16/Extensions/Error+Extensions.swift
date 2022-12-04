//
//  Error+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Error {
    public var underlyingError: Error? {
        let nsError = self as NSError
//        if nsError.domain == NSURLErrorDomain && nsError.code == -1009 {
//            // "The Internet connection appears to be offline."
//            return self
//        }
        return nsError.userInfo[NSUnderlyingErrorKey] as? Error
    }

    public var description: String {
        let nsError = self as NSError
        return nsError.description
    }
}
