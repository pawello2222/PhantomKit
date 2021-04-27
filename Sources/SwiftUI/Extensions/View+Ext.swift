//
//  View+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// MARK: - Color

extension View {
    public func bgColor(_ color: Color) -> some View {
        background(color)
    }
}

extension View {
    public func fgColor(_ color: Color) -> some View {
        foregroundColor(color)
    }
}

// MARK: - Frame

extension View {
    public func maxFrame() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension View {
    public func frameAction(_ action: @escaping () -> Void) -> some View {
        maxFrame()
            .contentShape(Rectangle())
            .onTapGesture(perform: action)
    }
}

// MARK: - Footer

extension View {
    // Overlay

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

    // Pinned

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

    // Default

    public func defaultFooter<Content>(
        _ content: @autoclosure () -> Content
    ) -> some View where Content: View {
        VStack {
            self
            content()
                .frame(maxWidth: .infinity)
                .padding()
        }
    }
}
