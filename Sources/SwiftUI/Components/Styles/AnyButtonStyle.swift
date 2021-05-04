//
//  AnyButtonStyle.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// MARK: - AnyButtonStyle

public struct AnyButtonStyle: ButtonStyle {
    private var _makeBody: (Self.Configuration) -> AnyView

    public init<S>(style: S) where S: ButtonStyle {
        _makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        _makeBody(configuration)
    }
}

// MARK: - AnyPrimitiveButtonStyle

public struct AnyPrimitiveButtonStyle: PrimitiveButtonStyle {
    private var _makeBody: (Self.Configuration) -> AnyView

    public init<S>(style: S) where S: PrimitiveButtonStyle {
        _makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        _makeBody(configuration)
    }
}
