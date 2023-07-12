//
//  SafariView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 09.06.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import SafariServices
import SwiftUI

public struct SafariView: View {
    private let url: URL
    private let tintColor: Color

    public init(url: URL, tintColor: Color = .accentColor) {
        self.url = url
        self.tintColor = tintColor
    }

    public var body: some View {
        SafariViewRepresentable(url: url, tintColor: tintColor)
            .ignoresSafeArea()
    }
}
