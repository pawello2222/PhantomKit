//
//  VScrollView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11/07/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

import SwiftUI

public struct VScrollView<Content>: View where Content: View {
    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                content()
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
            }
        }
    }
}
