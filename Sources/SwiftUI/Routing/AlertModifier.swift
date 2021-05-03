//
//  AlertModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

//public struct AlertModifier: ViewModifier {
//    private let content: () -> Alert
//
//    @State private var isActive = false
//
//    public init(@ViewBuilder content: @escaping () -> Alert) {
//        self.content = content
//    }
//
//    @ViewBuilder
//    public func body(content: Content) -> some View {
//        Button {
//            isActive = true
//        } label: {
//            content
//                .contentShape(Rectangle())
//        }
//        .alert(isPresented: $isActive, content: self.content)
//    }
//}
//
//// MARK: - View
//
//extension View {
//    public func alert(@ViewBuilder content: @escaping () -> Alert) -> some View {
//        modifier(AlertModifier(content: content))
//    }
//}
