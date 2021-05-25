//
//  String+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension String {
    public func inParentheses() -> String {
        "(\(self))"
    }
}

extension String {
    var isHexNumber: Bool {
        filter(\.isHexDigit).count == count
    }
}
