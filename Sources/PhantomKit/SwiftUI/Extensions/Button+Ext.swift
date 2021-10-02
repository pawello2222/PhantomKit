//
//  Button+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 18.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// swiftlint:disable multiple_closures_with_trailing_closure
extension Button where Label == Text {
    public init(_ title: String) {
        self.init(action: {}) {
            Text(title)
        }
    }
}

extension Button {
    public init(@ViewBuilder label: () -> Label) {
        self.init(action: {}, label: label)
    }
}
