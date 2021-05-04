//
//  TabViewItem.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 03.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct TabViewItem<Item>: ViewModifier where Item: Hashable {
    @Environment(\.tabSelection) private var tabSelection
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
                image
                if let title = title {
                    Text(title)
                }
            }
    }
}

extension TabViewItem {
    private var image: some View {
        guard
            tabSelection?.hashValue == item.hashValue,
            let uiImage = UIImage(systemName: imageName + ".fill")
        else {
            return Image(systemName: imageName)
        }
        return Image(uiImage: uiImage)
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
}
