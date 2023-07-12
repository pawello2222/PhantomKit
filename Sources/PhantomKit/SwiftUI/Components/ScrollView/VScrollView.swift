//
//  VScrollView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11/07/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

import SwiftUI

/// A vertical scrollable view with the content centered vertically.
///
/// The vertical scroll view displays its content within the scrollable content region.
/// As the user performs platform-appropriate scroll gestures, the scroll view
/// adjusts what portion of the underlying content is visible. `VScrollView` can
/// only scroll vertically and does not provide zooming functionality.
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
