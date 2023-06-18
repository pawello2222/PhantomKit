////
////  Button+Extensions.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 09/12/2022.
////  Copyright © 2022 Pawel Wiszenko. All rights reserved.
////
//
//import SwiftUI
//
//extension Button where Label == Text {
//    public init(_ titleKey: LocalizedStringKey, task: @escaping () async -> Void) {
//        self.init(titleKey) {
//            Task {
//                await task()
//            }
//        }
//    }
//
//    public init<S>(_ title: S, task: @escaping () async -> Void) where S: StringProtocol {
//        self.init(title) {
//            Task {
//                await task()
//            }
//        }
//    }
//}
