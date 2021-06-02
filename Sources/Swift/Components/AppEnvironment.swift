//
//  AppEnvironment.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 02.06.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

protocol AppEnvironmentProtocol {
    static func create()
}

extension AppEnvironmentProtocol {
    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
