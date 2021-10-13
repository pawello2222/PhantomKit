//
//  PrimitiveButtonStyle+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 13.10.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// MARK: - Dot Syntax Support

extension PrimitiveButtonStyle where Self == DefaultButtonStyle {
    public static var `default`: DefaultButtonStyle {
        .init()
    }
}
