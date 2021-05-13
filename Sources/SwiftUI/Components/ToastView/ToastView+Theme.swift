//
//  ToastView+Theme.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 13.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

public typealias ToastColorConfiguration = (text: UIColor, background: UIColor)

// MARK: - Custom keys

extension Theme {
    public var toastErrorColor: ToastColorConfiguration {
        get { userInfo[.toastErrorColor] as? ToastColorConfiguration ?? (text: .white, background: .systemRed) }
        set { userInfo[.toastErrorColor] = newValue }
    }

    public var toastInfoColor: ToastColorConfiguration {
        get { userInfo[.toastInfoColor] as? ToastColorConfiguration ?? (text: .white, background: .systemTeal) }
        set { userInfo[.toastInfoColor] = newValue }
    }

    public var toastSuccessColor: ToastColorConfiguration {
        get { userInfo[.toastSuccessColor] as? ToastColorConfiguration ?? (text: .white, background: .systemGreen) }
        set { userInfo[.toastSuccessColor] = newValue }
    }

    public var toastWarningColor: ToastColorConfiguration {
        get { userInfo[.toastWarningColor] as? ToastColorConfiguration ?? (text: .black, background: .systemYellow) }
        set { userInfo[.toastWarningColor] = newValue }
    }
}

// MARK: - UserInfo

extension UserInfoKey where Type == Theme {
    public static var toastErrorColor: Self { #function }
    public static var toastInfoColor: Self { #function }
    public static var toastSuccessColor: Self { #function }
    public static var toastWarningColor: Self { #function }
}
