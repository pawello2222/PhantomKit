//
//  String+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension String {
    public var isHexNumber: Bool {
        allSatisfy(\.isHexDigit)
    }
}
