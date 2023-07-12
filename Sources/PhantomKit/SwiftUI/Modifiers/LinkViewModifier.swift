//
//  LinkViewModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 06/07/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

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
