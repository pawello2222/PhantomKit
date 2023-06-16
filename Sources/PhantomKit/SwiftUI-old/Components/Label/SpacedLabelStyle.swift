////
////  SpacedLabelStyle.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 28.04.2021.
////  Copyright © 2021 Pawel Wiszenko. All rights reserved.
////
//
//import SwiftUI
//
///// A label style that adds a space between the title and the icon.
//public struct SpacedLabelStyle: LabelStyle {
//    @Environment(\.appTheme) private var theme
//
//    private var color: Color
//
//    public init(color: Color) {
//        self.color = color
//    }
//
//    public func makeBody(configuration: Self.Configuration) -> some View {
//        HStack {
//            titleView(with: configuration)
//            Spacer()
//            iconView(with: configuration)
//        }
//        .contentShape(Rectangle())
//    }
//
//    private func iconView(with configuration: Self.Configuration) -> some View {
//        configuration.icon
//            .imageScale(.large)
//            .foregroundStyle(color)
//    }
//
//    private func titleView(with configuration: Self.Configuration) -> some View {
//        configuration.title
//            .foregroundStyle(theme.primaryColor)
//    }
//}
//
//// MARK: - Dot Syntax Support
//
//extension LabelStyle where Self == SpacedLabelStyle {
//    /// A label style that adds a space between the title and the icon.
//    public static func spaced(color: Color) -> Self {
//        .init(color: color)
//    }
//}
