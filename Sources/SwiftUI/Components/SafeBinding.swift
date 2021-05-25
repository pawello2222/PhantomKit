//
//  SafeBinding.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct SafeBinding<Collection, Content>: View
    where Collection: RandomAccessCollection & MutableCollection, Content: View
{
    public typealias CollectionBinding = Binding<Collection>
    public typealias ElementBinding = Binding<Collection.Element>
    private let binding: ElementBinding
    private let content: (ElementBinding) -> Content

    public init(
        _ binding: CollectionBinding,
        index: Collection.Index,
        @ViewBuilder content: @escaping (ElementBinding) -> Content
    ) {
        self.content = content
        self.binding = .init(
            get: { binding.wrappedValue[index] },
            set: { binding.wrappedValue[index] = $0 }
        )
    }

    public var body: some View {
        content(binding)
    }
}
