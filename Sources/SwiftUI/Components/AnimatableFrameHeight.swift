//
//  AnimatableFrameHeight.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 28/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct AnimatableFrameHeight: AnimatableModifier {
    private var height: CGFloat

    public init(_ height: CGFloat = 0) {
        self.height = height
    }

    public var animatableData: CGFloat {
        get { height }
        set { height = newValue }
    }

    public func body(content: Content) -> some View {
        content
            .frame(height: height)
    }
}

// MARK: - View

extension View {
    public func animatableHeight(_ height: CGFloat = 0) -> some View {
        modifier(AnimatableFrameHeight(height))
    }
}
