//
//  MultiColumnList.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 06/07/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

import SwiftUI

public struct MultiColumnList<Content, Left, Right>: View where Content: View, Left: View, Right: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private let content: () -> Content
    private let left: () -> Left
    private let right: () -> Right

    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder left: @escaping () -> Left,
        @ViewBuilder right: @escaping () -> Right
    ) {
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

    private var isCompact: Bool {
        horizontalSizeClass == .compact
    }
}

// MARK: Content

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

// MARK: Convenience

extension MultiColumnList where Left == EmptyView {
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder right: @escaping () -> Right
    ) {
        self.content = content
        self.right = right
        left = {
            EmptyView()
        }
    }
}

extension MultiColumnList where Right == EmptyView {
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder left: @escaping () -> Left
    ) {
        self.content = content
        self.left = left
        right = {
            EmptyView()
        }
    }
}

extension MultiColumnList where Left == EmptyView, Right == EmptyView {
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
        left = {
            EmptyView()
        }
        right = {
            EmptyView()
        }
    }
}
