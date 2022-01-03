//
//  AboutView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 22.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct AboutView<
    Content: View,
    Header: View,
    Footer: View
>: View {
    @Environment(\.dismiss) private var dismiss

    private let content: () -> Content
    private let header: () -> Header
    private let footer: () -> Footer

    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self.content = content
        self.header = header
        self.footer = footer
    }

    public var body: some View {
        ZStack {
            VStack {
                header()
                Spacer()
                footer()
            }
            VStack(spacing: .s4) {
                content()
            }
        }
        .padding(.s6)
        .navigationBarHidden(true)
        .maxContentFrame()
        .action(triggeredBy: .tap) {
            dismiss()
        }
    }
}

// MARK: - Convenience

extension AboutView where Header == EmptyView {
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        header = { EmptyView() }
        self.footer = footer
        self.content = content
    }
}

extension AboutView where Footer == EmptyView {
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder header: @escaping () -> Header
    ) {
        self.header = header
        footer = { EmptyView() }
        self.content = content
    }
}

extension AboutView where Header == EmptyView, Footer == EmptyView {
    public init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        header = { EmptyView() }
        footer = { EmptyView() }
        self.content = content
    }
}
