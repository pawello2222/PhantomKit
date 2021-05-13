//
//  Alert+Button+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension Alert.Button {
    public static func `default`(_ title: String, action: (() -> Void)? = {}) -> Alert.Button {
        .default(Text(title), action: action)
    }

    public static func cancel(_ title: String, action: (() -> Void)? = {}) -> Alert.Button {
        .cancel(Text(title), action: action)
    }

    public static func destructive(_ title: String, action: (() -> Void)? = {}) -> Alert.Button {
        .destructive(Text(title), action: action)
    }
}

extension Alert.Button {
    public static func `default`(_ title: String, animatedAction: @escaping () -> Void) -> Alert.Button {
        .default(Text(title)) {
            withAnimation {
                animatedAction()
            }
        }
    }

    public static func cancel(_ title: String, animatedAction: @escaping () -> Void) -> Alert.Button {
        .cancel(Text(title)) {
            withAnimation {
                animatedAction()
            }
        }
    }

    public static func destructive(_ title: String, animatedAction: @escaping () -> Void) -> Alert.Button {
        .destructive(Text(title)) {
            withAnimation {
                animatedAction()
            }
        }
    }
}
