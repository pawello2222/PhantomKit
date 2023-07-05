//
//  LinkViewModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 06/07/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

import SwiftUI

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
            SafariView(url: url)
        }
    }
}

// MARK: - Convenience

extension View {
    @ViewBuilder
    public func link(url: URL?) -> some View {
        if let url {
            modifier(LinkViewModifier(url: url))
        } else {
            self
        }
    }
}
