//
//  WebEndpoint.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 30.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

public typealias WebEndpoint = AdaptiveURL

// MARK: - Custom keys

extension WebEndpoint {
    public var isNavigationAllowed: Bool {
        get { self[userInfoKey: .isNavigationAllowed, default: true] }
        set { self[userInfoKey: .isNavigationAllowed] = newValue }
    }

    public var hiddenWebElements: [String] {
        get { self[userInfoKey: .hiddenWebElements, default: []] }
        set { self[userInfoKey: .hiddenWebElements] = newValue }
    }
}

// MARK: - UserInfo

extension UserInfoKey where Type == WebEndpoint {
    public static var isNavigationAllowed: Self { #function }
    public static var hiddenWebElements: Self { #function }
}
