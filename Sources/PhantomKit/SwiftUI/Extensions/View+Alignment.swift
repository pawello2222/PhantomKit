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
