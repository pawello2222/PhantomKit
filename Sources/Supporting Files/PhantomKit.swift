//
//  PhantomKit.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

@_exported import Xcore

private class PhantomMarker {}

extension Bundle {
    public static var phantomKit: Bundle {
        .init(for: PhantomMarker.self)
    }
}
