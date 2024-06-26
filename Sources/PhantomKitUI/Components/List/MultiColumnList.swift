// The MIT License (MIT)
//
// Copyright (c) 2021-Present Paweł Wiszenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import SwiftUI

/// Specifies when the list should be displayed in the compact mode.
public enum MultiColumnListCompactMode {
    case horizontalSizeClass
    #if os(iOS) || os(tvOS)
    case userInterfaceIdiom
    #endif
}

/// A container that is a single List in compact widths
/// or a three-column List in regular widths.
public struct MultiColumnList<
    Content, Left, Right
>: View where Content: View, Left: View, Right: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private let mode: MultiColumnListCompactMode
    private let content: () -> Content
    private let left: () -> Left
    private let right: () -> Right

    public init(
        mode: MultiColumnListCompactMode = .horizontalSizeClass,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder left: @escaping () -> Left,
        @ViewBuilder right: @escaping () -> Right
    ) {
        self.mode = mode
        self.content = content
        self.left = left
        self.right = right
    }

    public var body: some View {
        HStack(spacing: 0) {
            leftView
            contentView
            rightView
        }
        .scrollIndicators(.hidden)
    }
}

// MARK: - Content

extension MultiColumnList {
    private var contentView: some View {
        List {
            if isCompact {
                left()
            }
            content()
            if isCompact {
                right()
            }
        }
    }

    @ViewBuilder
    private var leftView: some View {
        if !isCompact, Left.self != EmptyView.self {
            List {
                left()
            }
        }
    }

    @ViewBuilder
    private var rightView: some View {
        if !isCompact, Right.self != EmptyView.self {
            List {
                right()
            }
        }
    }
}

// MARK: - Helpers

extension MultiColumnList {
    private var isCompact: Bool {
        switch mode {
        case .horizontalSizeClass:
            horizontalSizeClass == .compact
        #if os(iOS) || os(tvOS)
        case .userInterfaceIdiom:
            UIDevice.current.userInterfaceIdiom == .phone
        #endif
        }
    }
}

// MARK: - Convenience

extension MultiColumnList where Left == EmptyView {
    public init(
        mode: MultiColumnListCompactMode = .horizontalSizeClass,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder right: @escaping () -> Right
    ) {
        self.mode = mode
        self.content = content
        self.right = right
        left = {
            EmptyView()
        }
    }
}

extension MultiColumnList where Right == EmptyView {
    public init(
        mode: MultiColumnListCompactMode = .horizontalSizeClass,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder left: @escaping () -> Left
    ) {
        self.mode = mode
        self.content = content
        self.left = left
        right = {
            EmptyView()
        }
    }
}

extension MultiColumnList where Left == EmptyView, Right == EmptyView {
    public init(
        mode: MultiColumnListCompactMode = .horizontalSizeClass,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.mode = mode
        self.content = content
        left = {
            EmptyView()
        }
        right = {
            EmptyView()
        }
    }
}
