//
//  Theme+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 28.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

// MARK: - Common Theme

extension Theme {
    public static let common: Theme = .default.applying {
        $0.id = "common"
        $0.gradientColors = [.systemRed, .systemOrange]
        $0.gradientDisabledColors = [.gray, .lightGray]
    }
}

// MARK: - Custom keys

extension Theme {
    public var gradientColors: [UIColor] {
        get { userInfo[.gradientColors] as? [UIColor] ?? [accentColor] }
        set { userInfo[.gradientColors] = newValue }
    }

    public var gradientDisabledColors: [UIColor] {
        get { userInfo[.gradientDisabledColors] as? [UIColor] ?? [backgroundSecondaryColor] }
        set { userInfo[.gradientDisabledColors] = newValue }
    }
}

// MARK: - UserInfo

extension UserInfoKey where Type == Theme {
    public static var gradientColors: Self { #function }
    public static var gradientDisabledColors: Self { #function }
}
