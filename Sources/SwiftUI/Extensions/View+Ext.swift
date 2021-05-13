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
}

// MARK: - Fixed size

extension View {
    @inlinable public func fixedSize(_ edges: Edge.Set) -> some View {
        let horizontal = !edges.isDisjoint(with: .horizontal)
        let vertical = !edges.isDisjoint(with: .vertical)
        return fixedSize(horizontal: horizontal, vertical: vertical)
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

// MARK: - Navigation

extension View {
    public func embedInNavigation(_ title: String) -> some View {
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
