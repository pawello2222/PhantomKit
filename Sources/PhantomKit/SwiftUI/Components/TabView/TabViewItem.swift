//
//  TabViewItem.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 03.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI
import Xcore

public struct TabViewItem<Tag, Title>: ViewModifier where Tag: Hashable, Title: StringProtocol {
    private let tag: Tag
    private let title: Title
    private let imageName: String

    public init(tag: Tag, title: Title, imageName: String) {
        self.tag = tag
        self.title = title
        self.imageName = imageName
    }

    public func body(content: Content) -> some View {
        content
            .tag(tag)
            .tabItem {
                Label(title, systemImage: imageName)
            }
    }
}

// MARK: - View

extension View {
    public func tabItem<Tag, Title>(
        tag: Tag,
        title: Title,
        systemImage: SystemAssetIdentifier
    ) -> some View where Tag: Hashable, Title: StringProtocol {
        modifier(TabViewItem(tag: tag, title: title, imageName: systemImage.rawValue))
    }

    public func tabItem<Item>(
        _ item: Item,
        systemImage: SystemAssetIdentifier
    ) -> some View where Item: Hashable & CustomStringConvertible {
        modifier(TabViewItem(tag: item, title: item.description, imageName: systemImage.rawValue))
    }
}
