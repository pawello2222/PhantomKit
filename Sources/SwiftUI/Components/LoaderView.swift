//
//  LoaderView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 02.06.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct LoaderView: View {
    @Environment(\.appTheme) private var theme

    private let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        VStack(spacing: .defaultPadding) {
            ProgressView()
                .progressViewStyle(ContinuousProgressViewStyle())
                .frame(45)
            Text(title)
                .foregroundColor(theme.secondaryColor)
        }
        .expandingBackgroundColor(theme.backgroundColor)
    }
}
