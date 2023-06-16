//
//  View+Alignment.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04.12.2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension View {
    /// Aligns the content based on the given alignment by wrapping the content
    /// in an `HStack`.
    public func alignment(horizontal alignment: HorizontalAlignment) -> some View {
        modifier(HorizontalAlignmentViewModifier(alignment))
    }

    /// Aligns the content based on the given alignment by wrapping the content
    /// in a `VStack`.
    public func alignment(vertical alignment: VerticalAlignment) -> some View {
        modifier(VerticalAlignmentViewModifier(alignment))
    }

    /// Aligns the content based on the given alignment by wrapping the content
    /// in a `ZStack`.
    public func alignment(_ alignment: Alignment) -> some View {
        modifier(AlignmentViewModifier(alignment))
    }
}

// MARK: - HorizontalAlignment

private struct HorizontalAlignmentViewModifier: ViewModifier {
    private let alignment: HorizontalAlignment

    init(_ alignment: HorizontalAlignment) {
        self.alignment = alignment
    }

    func body(content: Content) -> some View {
        HStack(spacing: 0) {
            switch alignment {
            case .leading:
                content
                Spacer(minLength: 0)
            case .center:
                Spacer(minLength: 0)
                content
                Spacer(minLength: 0)
            case .trailing:
                Spacer(minLength: 0)
                content
            default:
                content
            }
        }
    }
}

// MARK: - VerticalAlignment

private struct VerticalAlignmentViewModifier: ViewModifier {
    private let alignment: VerticalAlignment

    init(_ alignment: VerticalAlignment) {
        self.alignment = alignment
    }

    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            switch alignment {
            case .top:
                content
                Spacer(minLength: 0)
            case .center:
                Spacer(minLength: 0)
                content
                Spacer(minLength: 0)
            case .bottom:
                Spacer(minLength: 0)
                content
            default:
                content
            }
        }
    }
}

// MARK: - Alignment

private struct AlignmentViewModifier: ViewModifier {
    private let alignment: Alignment

    init(_ alignment: Alignment) {
        self.alignment = alignment
    }

    func body(content: Content) -> some View {
        ZStack(alignment: alignment) {
            Color.clear
            content
        }
    }
}
