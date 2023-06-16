////
////  SearchBar.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 28.05.2021.
////  Copyright © 2021 Pawel Wiszenko. All rights reserved.
////
//
//import SwiftUI
//
//public struct SearchBar: View {
//    @Environment(\.appTheme) private var theme
//    private let placeholder: String
//    @Binding private var text: String
//
//    public init(_ placeholder: String, text: Binding<String>) {
//        self.placeholder = placeholder
//        _text = text
//    }
//
//    public var body: some View {
//        HStack {
//            textView
//            imageView
//        }
//        .padding(.vertical, .s2)
//        .padding(.horizontal)
//        .backgroundColor(theme.backgroundSecondaryColor)
//        .clipShape(RoundedRectangle(cornerRadius: 12))
//    }
//
//    private var textView: some View {
//        TextField(placeholder, text: $text)
//            .autocapitalization(.none)
//            .disableAutocorrection(true)
//    }
//
//    @ViewBuilder
//    private var imageView: some View {
//        if text.isEmpty {
//            Image(system: .magnifyingGlass)
//        } else {
//            Image(system: .xMarkCircleFill)
//                .action(triggeredBy: .plainButton) {
//                    text = ""
//                    UIApplication.shared.endEditing()
//                }
//        }
//    }
//}
