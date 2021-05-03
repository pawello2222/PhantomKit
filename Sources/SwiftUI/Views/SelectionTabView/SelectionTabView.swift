//
//  SelectionTabView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 03.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct SelectionTabView<Selection, Content>: View where Selection: Hashable, Content: View {
    @Binding private var selection: Selection
    private let content: () -> Content

    public init(selection: Binding<Selection>, @ViewBuilder content: @escaping () -> Content) {
        _selection = selection
        self.content = content
    }

    public var body: some View {
        TabView(selection: $selection) {
            content()
        }
        .tabSelection(selection)
    }
}
