////
////  PresentationViewModifier.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 26.04.2021.
////  Copyright © 2021 Pawel Wiszenko. All rights reserved.
////
//
//import SwiftUI
//
//public struct PresentationViewModifier<R>: ViewModifier where R: Route {
//    private let presentation: Presentation
//    private let onTrigger: (() -> Void)?
//    private let onDismiss: (() -> Void)?
//    private let route: R
//
//    @State private var isActive = false
//
//    public init(
//        presentation: Presentation = .link,
//        onTrigger: (() -> Void)? = nil,
//        onDismiss: (() -> Void)? = nil,
//        route: R
//    ) {
//        self.presentation = presentation
//        self.onTrigger = onTrigger
//        self.onDismiss = onDismiss
//        self.route = route
//    }
//
//    @ViewBuilder
//    public func body(content: Content) -> some View {
//        transitionBody(
//            content
//                .modifier(
//                    PresentationTriggerViewModifier(
//                        trigger: presentation.trigger,
//                        isActive: $isActive,
//                        onTrigger: onTrigger
//                    )
//                )
//        )
//    }
//}
//
//// MARK: - Transition Body
//
//extension PresentationViewModifier {
//    @ViewBuilder
//    private func transitionBody(_ content: some View) -> some View {
//        switch presentation.transition {
//        case .link:
//            content
//                .background(NavigationLink("", destination: route.view(), isActive: $isActive).hidden())
//        case .sheet:
//            content
//                .sheet(isPresented: $isActive, onDismiss: onDismiss, content: route.view)
//        case .fullScreen:
//            content
//                .fullScreenCover(isPresented: $isActive, onDismiss: onDismiss, content: route.view)
//        }
//    }
//}
