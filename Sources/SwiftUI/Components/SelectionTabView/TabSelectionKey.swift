//
//  TabSelectionKey.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 03.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension EnvironmentValues {
    private struct TabSelectionKey: EnvironmentKey {
        static var defaultValue: AnyHashable?
    }

    public var tabSelection: AnyHashable? {
        get { self[TabSelectionKey.self] }
        set { self[TabSelectionKey.self] = newValue }
    }
}

// MARK: - View

extension View {
    public func tabSelection<Selection>(_ selection: Selection) -> some View where Selection: Hashable {
        environment(\.tabSelection, selection)
    }

    public func tabSelection<Selection>(_ selection: Binding<Selection>) -> some View where Selection: Hashable {
        tabSelection(selection.wrappedValue)
    }
}
