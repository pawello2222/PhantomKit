//
//  FullScreenViewModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11/07/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

import SwiftUI

public struct FullScreenViewModifier<Destination>: ViewModifier where Destination: View {
    @State private var isPresented = false

    private let destination: () -> Destination

    public init(@ViewBuilder destination: @escaping () -> Destination) {
        self.destination = destination
    }

    public func body(content: Content) -> some View {
        Button {
            isPresented.toggle()
        } label: {
            content
        }
        .fullScreenCover(isPresented: $isPresented) {
            destination()
        }
    }
}

// MARK: - Convenience

extension View {
    public func fullScreen<Destination>(
        @ViewBuilder _ destination: @escaping () -> Destination
    ) -> some View where Destination: View {
        modifier(FullScreenViewModifier(destination: destination))
    }
}