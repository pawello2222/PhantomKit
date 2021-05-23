//
//  View+Helpers.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 29.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct IndicatorView: View {
    public init() {}

    public var body: some View {
        Image(system: .chevronRight)
            .imageScale(.small)
            .font(Font.app(.body).weight(.semibold))
            .foregroundUIColor(.systemGray4)
    }
}

public struct InvisibleShape: View {
    public init() {}

    public var body: some View {
        Color.black
            .opacity(.minimumOpacity)
    }
}

public struct SpacerView: View {
    private let width: CGFloat?
    private let height: CGFloat?

    public init(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.width = width
        self.height = height
    }

    public var body: some View {
        Spacer()
            .frame(width: width, height: height)
    }
}

public struct Unwrap<Value, Content>: View where Content: View {
    private let value: Value?
    private let content: (Value) -> Content

    public init(_ value: Value?, @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        self.content = content
    }

    public var body: some View {
        if let value = value {
            content(value)
        }
    }
}
