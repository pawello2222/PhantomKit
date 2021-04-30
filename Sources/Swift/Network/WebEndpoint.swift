//
//  WebEndpoint.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 30/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

public typealias WebEndpoint = AdaptiveURL

// MARK: - UserInfo

extension UserInfoKey where Type == WebEndpoint {
    public static var isNavigationAllowed: Self { #function }
}

extension WebEndpoint {
    public var isNavigationAllowed: Bool {
        get { self[userInfoKey: .isNavigationAllowed, default: true] }
        set { self[userInfoKey: .isNavigationAllowed] = newValue }
    }
}
