//
//  View+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// MARK: - Border

extension View {
    @inlinable public func borderColor(_ color: Color, width: CGFloat = 1) -> some View {
        border(color, width: width)
    }

    @inlinable public func borderUIColor(_ uiColor: UIColor, width: CGFloat = 1) -> some View {
        borderColor(.init(uiColor), width: width)
    }
}

// MARK: - Color

extension View {
    @inlinable public func accentUIColor(_ uiColor: UIColor) -> some View {
        accentColor(.init(uiColor))
    }

    @inlinable public func bgColor(_ color: Color) -> some View {
        background(color)
    }

    @inlinable public func fgColor(_ color: Color) -> some View {
        foregroundColor(color)
    }
}

// MARK: - Frame

extension View {
    @inlinable public func maximumFrame() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    @inlinable public func onTapFrame(perform action: @escaping () -> Void) -> some View {
        maximumFrame()
            .contentShape(Rectangle())
            .onTapGesture(perform: action)
    }

    @inlinable public func onTapFrame(perform action: @autoclosure @escaping () -> Void) -> some View {
        onTapFrame(perform: action)
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

// MARK: - Navigation

extension View {
    public func embedInNavigation(_ title: String) -> some View {
        navigationTitle(title)
            .embedInNavigation()
    }
}

extension View {
    public func embedInStackNavigation() -> some View {
        embedInNavigation()
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - Overlay

extension View {
    public func invisibleOverlay<Content>(
        content: @escaping (InvisibleShape) -> Content
    ) -> some View where Content: View {
        overlay(
            content(InvisibleShape())
        )
    }
}

// MARK: - Toolbar

extension View {
    public func toolbar<Content>(
        _ content: @autoclosure () -> Content
    ) -> some View where Content: ToolbarContent {
        toolbar {
            content()
        }
    }
}
