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

/// A view modifier that creates a button that presents a Safari view
/// as a modal view that covers as much of the screen as possible.
public struct LinkViewModifier: ViewModifier {
    @State private var isPresented = false

    private let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func body(content: Content) -> some View {
        Button {
            isPresented.toggle()
        } label: {
            content
        }
        .fullScreenCover(isPresented: $isPresented) {
            SafariViewRepresentable(url: url)
                .ignoresSafeArea()
        }
    }
}

// MARK: - Convenience

extension View {
    /// Creates a button that presents a Safari view as a modal view
    /// that covers as much of the screen as possible.
    @ViewBuilder
    public func link(url: URL?) -> some View {
        if let url {
            modifier(LinkViewModifier(url: url))
        } else {
            self
        }
    }
}
