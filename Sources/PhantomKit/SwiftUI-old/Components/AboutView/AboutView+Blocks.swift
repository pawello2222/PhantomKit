////
////  AboutView+Blocks.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 25.04.2021.
////  Copyright © 2021 Pawel Wiszenko. All rights reserved.
////
//
//import SwiftUI
//import Xcore
//
//// MARK: - Common
//
//extension AboutView where Header == EmptyView, Footer == EmptyView, Content == EmptyView {
//    public static func logo(
//        imageName: String,
//        endpoint: WebEndpoint? = nil
//    ) -> some View {
//        Image(imageName)
//            .resizable()
//            .scaledToFit()
//            .padding()
//            .unwrap(endpoint) {
//                $0.safariView(endpoint: $1)
//            }
//    }
//
//    public static func section<C>(
//        title: String,
//        @ViewBuilder content: @escaping () -> C
//    ) -> some View where C: View {
//        VStack(spacing: .s3) {
//            Text(title.uppercased())
//                .font(.subheadline)
//                .foregroundStyle(.secondary)
//            content()
//        }
//    }
//
//    public static func text(_ title: String) -> some View {
//        Text(title)
//            .font(.body)
//    }
//
//    public static func link(_ title: String, endpoint: WebEndpoint) -> some View {
//        Text(title)
//            .underline()
//            .font(.body)
//            .safariView(endpoint: endpoint)
//    }
//
//    public static func copyright(author: String, startYear: Int? = nil) -> some View {
//        let endYear = Date().component(.year)
//        var components = ["©"]
//        if let startYear = startYear, startYear < endYear {
//            components.append("\(startYear)-\(endYear)")
//        } else {
//            components.append("\(endYear)")
//        }
//        components.append(author)
//        return Text(components.joined(separator: " "))
//            .font(.callout)
//    }
//}
//
//// MARK: - Convenience
//
//extension AboutView where Header == EmptyView, Footer == EmptyView, Content == EmptyView {
//    public static func logo(
//        asset: ImageAssetIdentifier,
//        endpoint: WebEndpoint? = nil
//    ) -> some View {
//        AboutView.logo(imageName: asset.rawValue, endpoint: endpoint)
//    }
//
//    public static func section(title: String, text: String) -> some View {
//        AboutView.section(title: title) {
//            AboutView.text(text)
//        }
//    }
//}
