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
    public static let common = Theme.default.applying {
        $0.id = #function
        $0.userInfo[.gradientColors] = [UIColor.systemRed, .systemOrange]
        $0.userInfo[.gradientDisabledColors] = [UIColor.gray, .lightGray]
    }
}

// MARK: - Custom keys

extension Theme {
    public var gradientColors: [UIColor] {
        userInfo[.gradientColors] as? [UIColor] ?? [.systemTint]
    }

    public var gradientDisabledColors: [UIColor] {
        userInfo[.gradientDisabledColors] as? [UIColor] ?? [.secondarySystemBackground]
    }
}

// MARK: - UserInfoKey

extension UserInfoKey where Type == Theme {
    public static var gradientColors: Self { #function }
    public static var gradientDisabledColors: Self { #function }
}
