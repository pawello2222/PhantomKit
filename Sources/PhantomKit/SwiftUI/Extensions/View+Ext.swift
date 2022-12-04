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

// MARK: - Background

extension View {
    public func expandingBackground<V>(
        _ background: @autoclosure @escaping () -> V,
        ignoresSafeAreaEdges edges: Edge.Set = .all
    ) -> some View where V: View {
        expandingBackground(
            ignoresSafeAreaEdges: edges,
            background: background
        )
    }
}

extension View {
    public func expandingBackground<V>(
        ignoresSafeAreaEdges edges: Edge.Set = .all,
        @ViewBuilder background: @escaping () -> V
    ) -> some View where V: View {
        ZStack {
            background()
                .ignoresSafeArea(.all, edges: edges)
            self
        }
    }
}

// MARK: - Navigation

extension View {
    public func embedInNavigation(title: String) -> some View {
        NavigationView {
            self.navigationTitle(title)
        }
    }

    public func embedInStackNavigation() -> some View {
        NavigationView {
            self
        }
        .navigationViewStyle(.stack)
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
