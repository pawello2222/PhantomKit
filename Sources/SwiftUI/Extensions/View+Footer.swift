//
//  View+Footer.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 13.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// MARK: Default

extension View {
    public func defaultFooter<Content>(
        @ViewBuilder content: () -> Content
    ) -> some View where Content: View {
        VStack {
            self
            content()
                .frame(maxWidth: .infinity)
                .padding()
        }
    }

    public func defaultFooter<Content>(
        _ content: @autoclosure () -> Content
    ) -> some View where Content: View {
        defaultFooter(content: content)
    }
}

// MARK: Overlay

extension View {
    public func overlayFooter<Content>(
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> some View where Content: View {
        ZStack(alignment: .init(horizontal: alignment, vertical: .bottom)) {
            self
            content()
        }
    }

    public func overlayFooter<Content>(
        alignment: HorizontalAlignment = .center,
        _ content: @autoclosure () -> Content
    ) -> some View where Content: View {
        overlayFooter(alignment: alignment, content: content)
    }
}

// MARK: Pinned

extension View {
    public func pinnedFooter<Content>(
        alignment: HorizontalAlignment = .center,
        spacing: CGFloat? = nil,
        @ViewBuilder content: () -> Content
    ) -> some View where Content: View {
        VStack(alignment: alignment, spacing: spacing) {
            self
            content()
                .frame(maxWidth: .infinity)
        }
    }

    public func pinnedFooter<Content>(
        alignment: HorizontalAlignment = .center,
        spacing: CGFloat? = nil,
        _ content: @autoclosure () -> Content
    ) -> some View where Content: View {
        pinnedFooter(alignment: alignment, spacing: spacing, content: content)
    }
}
