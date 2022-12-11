////
////  PresentationTriggerViewModifier.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 04.05.2021.
////  Copyright © 2021 Pawel Wiszenko. All rights reserved.
////
//
//import SwiftUI
//
//struct PresentationTriggerViewModifier: ViewModifier {
//    let trigger: Presentation.Trigger
//    @Binding var isActive: Bool
//    var onTrigger: (() -> Void)?
//
//    @ViewBuilder
//    func body(content: Content) -> some View {
//        switch trigger {
//        case .tap:
//            content
//                .onTapGesture {
//                    onTrigger?()
//                    isActive = true
//                }
//        case .button:
//            Button {
//                onTrigger?()
//                isActive = true
//            } label: {
//                content
//                    .contentShape(Rectangle())
//            }
//        }
//    }
//}
