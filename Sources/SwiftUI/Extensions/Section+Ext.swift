//
//  Section+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension Section {
    public init(
        title: String,
        @ViewBuilder content: @escaping () -> Content
    ) where Parent == Text, Footer == EmptyView, Content: View {
        self.init(header: Text(title), content: content)
    }

    public init(header: Parent) where Parent: View, Footer == EmptyView, Content == EmptyView {
        self.init(header: header, content: {})
    }
}
