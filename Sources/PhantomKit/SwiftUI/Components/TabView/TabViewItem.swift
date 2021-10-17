//
//  TabViewItem.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 03.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct TabViewItem<Item>: ViewModifier where Item: Hashable {
    private let item: Item
    private let title: String?
    private let imageName: String

    public init(_ item: Item, title: String? = nil, imageName: String) {
        self.item = item
        self.title = title
        self.imageName = imageName
    }

    public func body(content: Content) -> some View {
        content
            .tag(item)
            .tabItem {
                Image(systemName: imageName)
                if let title = title {
                    Text(title)
                }
            }
    }
}

// MARK: - View

extension View {
    public func tabItem<Item>(
        _ item: Item,
        title: String? = nil,
        systemImage: SystemAssetIdentifier
    ) -> some View where Item: Hashable {
        modifier(TabViewItem(item, title: title, imageName: systemImage.rawValue))
    }

    public func tabItem<Item>(
        _ item: Item,
        systemImage: SystemAssetIdentifier
    ) -> some View where Item: Hashable & CustomStringConvertible {
        modifier(TabViewItem(item, title: item.description, imageName: systemImage.rawValue))
    }
}
