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

// MARK: - Convenience

extension View {
    /// Wraps this view with a type eraser.
    public func eraseToAnyView() -> AnyView {
        .init(self)
    }
}

// MARK: - Background

extension View {
    /// Wraps this view in an `ZStack` and puts the background behind it.
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
    /// Wraps this view in an `ZStack` and puts the background behind it.
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

// MARK: - FixedSize

extension View {
    /// Fixes this view at its ideal size on the given axis.
    ///
    /// - Parameters:
    ///   - axis: A Boolean value that indicates on which axis to fix the size
    ///     of the view.
    /// - Returns: A view that fixes this view at its ideal size on the given `axis`.
    public func fixedSize(_ axis: Axis) -> some View {
        switch axis {
        case .horizontal:
            return fixedSize(horizontal: true, vertical: false)
        case .vertical:
            return fixedSize(horizontal: false, vertical: true)
        }
    }
}

// MARK: - Footer

extension View {
    public func pinnedFooter<Content>(
        spacing: CGFloat? = nil,
        @ViewBuilder content: () -> Content
    ) -> some View where Content: View {
        VStack(spacing: spacing) {
            self
            content()
                .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Frame

extension View {
    /// Positions this view within an invisible frame with the specified size.
    public func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        frame(width: size.width, height: size.height, alignment: alignment)
    }

    /// Positions this view within an invisible frame with the specified size.
    public func frame(length: CGFloat, alignment: Alignment = .center) -> some View {
        frame(width: length, height: length, alignment: alignment)
    }

    /// Positions this view within an invisible frame having the specified size
    /// constraints.
    public func frame(min: CGFloat, alignment: Alignment = .center) -> some View {
        frame(minWidth: min, minHeight: min, alignment: alignment)
    }

    /// Positions this view within an invisible frame having the specified size
    /// constraints.
    public func frame(max: CGFloat, alignment: Alignment = .center) -> some View {
        frame(maxWidth: max, maxHeight: max, alignment: alignment)
    }
}

// MARK: - Gestures

extension View {
    /// Creates a rectangular content shape and adds an action to perform
    /// when this view recognizes a tap gesture.
    public func onTap(
        count: Int = 1,
        perform action: @escaping () -> Void
    ) -> some View {
        contentShape(Rectangle())
            .onTapGesture(count: count, perform: action)
    }
}

// MARK: - Visibility

extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder
    public func hidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
