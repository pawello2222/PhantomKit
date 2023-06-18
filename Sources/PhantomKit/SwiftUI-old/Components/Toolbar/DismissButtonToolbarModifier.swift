////
////  DismissButtonToolbarModifier.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 10.05.2021.
////  Copyright © 2021 Pawel Wiszenko. All rights reserved.
////
//
//import SwiftUI
//
///// A modifier that adds a dismiss button to the toolbar.
//public struct DismissButtonToolbarModifier: ViewModifier {
//    @Environment(\.dismiss) private var dismiss
//
//    private let title: String
//    private let placement: ToolbarItemPlacement
//    private let onDismiss: (() -> Void)?
//
//    public init(
//        title: String,
//        placement: ToolbarItemPlacement,
//        onDismiss: (() -> Void)? = nil
//    ) {
//        self.title = title
//        self.placement = placement
//        self.onDismiss = onDismiss
//    }
//
//    public func body(content: Content) -> some View {
//        content
//            .toolbar {
//                ToolbarItem(placement: placement) {
//                    Button(title) {
//                        onDismiss?()
//                        dismiss()
//                    }
//                }
//            }
//    }
//}
//
//// MARK: - View
//
//extension View {
//    /// A modifier that adds a dismiss button to the toolbar.
//    public func dismissButtonToolbar(
//        _ title: String,
//        onDismiss: (() -> Void)? = nil
//    ) -> some View {
//        modifier(
//            DismissButtonToolbarModifier(
//                title: title,
//                placement: .cancellationAction,
//                onDismiss: onDismiss
//            )
//        )
//    }
//}
