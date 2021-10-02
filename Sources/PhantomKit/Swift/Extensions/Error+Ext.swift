//
//  Error+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 08.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Error {
    public var nsErrorDescription: String {
        (self as NSError).description
    }
}
