////
////  AnimatedButton.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 18.05.2021.
////  Copyright © 2021 Pawel Wiszenko. All rights reserved.
////
//
//import SwiftUI
//
//public struct AnimatedButton<Label>: View where Label: View {
//    private let role: ButtonRole?
//    private let action: () -> Void
//    private let label: () -> Label
//
//    public init(
//        role: ButtonRole? = nil,
//        action: @escaping () -> Void,
//        @ViewBuilder label: @escaping () -> Label
//    ) {
//        self.role = role
//        self.action = action
//        self.label = label
//    }
//
//    public var body: some View {
//        Button(role: role) {
//            withAnimation {
//                action()
//            }
//        } label: {
//            label()
//        }
//    }
//}
//
//// MARK: - Convenience
//
//extension AnimatedButton where Label == Text {
//    public init(
//        _ title: String,
//        role: ButtonRole? = nil,
//        action: @escaping () -> Void
//    ) {
//        self.init(role: role, action: action) {
//            Text(title)
//        }
//    }
//}
