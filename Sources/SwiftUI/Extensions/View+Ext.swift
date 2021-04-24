//
//  View+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

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
