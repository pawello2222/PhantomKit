//
//  Button+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 18.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension Button where Label == Text {
    public init(title: String) {
        self.init(action: {}) {
            Text(title)
        }
    }
}

extension Button {
    public init(label: () -> Label) {
        self.init(action: {}, label: label)
    }
}
