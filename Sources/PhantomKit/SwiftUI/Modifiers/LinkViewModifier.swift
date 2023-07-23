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

/// A view modifier that creates a button that opens a given link in an external browser.
public struct ExternalLinkViewModifier: ViewModifier {
    @Environment(\.openURL) private var openURL

    private let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func body(content: Content) -> some View {
        Button {
            openURL(url)
        } label: {
            content
        }
    }
}

#if os(iOS)

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

#endif

// MARK: - Convenience

extension View {
    /// Creates a button that presents a URL according to the provided options.
    @ViewBuilder
    public func link(url: URL?, openedAs method: LinkOpenMethod = .default) -> some View {
        if let url {
            switch method {
            case .external:
                modifier(ExternalLinkViewModifier(url: url))
            #if os(iOS)
            case .fullscreen:
                modifier(LinkViewModifier(url: url))
            #endif
            }
        } else {
            self
        }
    }
}

// MARK: - LinkOpenMethod

public enum LinkOpenMethod {
    /// Opens a link in an external browser.
    case external

    #if os(iOS)
    /// Opens a link in a Safari view presented as a modal view
    /// that covers as much of the screen as possible.
    case fullscreen
    #endif
}

extension LinkOpenMethod {
    #if os(iOS)
    public static var `default`: Self = .fullscreen
    #else
    public static var `default`: Self = .external
    #endif
}
