//
//  View+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// MARK: - Align

extension View {
    public func aligned(_ alignemnt: HorizontalAlignment) -> some View {
        HStack {
            if alignemnt == .trailing {
                Spacer()
            }
            self
            if alignemnt == .leading {
                Spacer()
            }
        }
    }

    public func aligned(_ alignemnt: VerticalAlignment) -> some View {
        VStack {
            if alignemnt == .bottom {
                Spacer()
            }
            self
            if alignemnt == .top {
                Spacer()
            }
        }
    }
}

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

    public func expandingBackgroundUIColor(_ uiColor: UIColor, edgesIgnoringSafeArea: Edge.Set = .all) -> some View {
        expandingBackgroundColor(.init(uiColor), edgesIgnoringSafeArea: edgesIgnoringSafeArea)
    }

    public func expandingBackgroundColor(_ color: Color, edgesIgnoringSafeArea: Edge.Set = .all) -> some View {
        ZStack {
            color
                .edgesIgnoringSafeArea(edgesIgnoringSafeArea)
            self
        }
    }
}

// MARK: - Fixed size

extension View {
    @inlinable public func fixedSize(_ edges: Edge.Set = .all) -> some View {
        let horizontal = !edges.isDisjoint(with: .horizontal)
        let vertical = !edges.isDisjoint(with: .vertical)
        return fixedSize(horizontal: horizontal, vertical: vertical)
    }
}

// MARK: - Frame

extension View {
    @inlinable public func maxFrame(_ edges: Edge.Set = .all) -> some View {
        let maxWidth: CGFloat? = !edges.isDisjoint(with: .horizontal) ? .infinity : nil
        let maxHeight: CGFloat? = !edges.isDisjoint(with: .vertical) ? .infinity : nil
        return frame(maxWidth: maxWidth, maxHeight: maxHeight)
    }

    @inlinable public func maxContentFrame(_ edges: Edge.Set = .all) -> some View {
        maxFrame(edges)
            .contentShape(Rectangle())
    }
}

// MARK: - Navigation

extension View {
    public func embedInNavigation(title: String) -> some View {
        navigationTitle(title)
            .embedInNavigation()
    }

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
