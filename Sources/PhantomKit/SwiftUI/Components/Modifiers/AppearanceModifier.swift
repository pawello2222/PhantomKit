////
////  AppearanceModifier.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 03.05.2021.
////  Copyright © 2021 Pawel Wiszenko. All rights reserved.
////
//
//import SwiftUI
//
//public struct AppearanceModifier: ViewModifier {
//    private let theme: AppTheme
//
//    public init(theme: AppTheme = .default) {
//        self.theme = theme
//    }
//
//    public func body(content: Content) -> some View {
//        content
//            .tint(theme.accentColor)
//            .appTheme(theme)
//    }
//}
//
//// MARK: - View
//
//extension View {
//    public func appearance(theme: AppTheme = .default) -> some View {
//        modifier(AppearanceModifier(theme: theme))
//    }
//}
