//
//  View+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// MARK: - Color

extension View {
    public func bgColor(_ color: Color) -> some View {
        background(color)
    }
}

extension View {
    public func fgColor(_ color: Color) -> some View {
        foregroundColor(color)
    }
}

// MARK: - Frame

extension View {
    public func maxFrame() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension View {
    public func frameAction(_ action: @escaping () -> Void) -> some View {
        maxFrame()
            .contentShape(Rectangle())
            .onTapGesture(perform: action)
    }
}
