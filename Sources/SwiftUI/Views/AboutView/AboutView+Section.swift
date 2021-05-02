//
//  AboutView+Section.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension AboutView {
    public struct Section {
        let title: String
        let items: [Item]

        public init(title: String, items: [Item]) {
            self.title = title
            self.items = items
        }
    }
}

// MARK: - View

extension AboutView.Section {
    struct ContentView: View {
        @Environment(\.theme) private var theme
        let section: AboutView.Section

        var body: some View {
            VStack(spacing: .defaultPadding) {
                Text(section.title.uppercased())
                    .font(.app(.subheadline, weight: .semibold))
                    .foregroundUIColor(theme.textSecondaryColor)
                ForEach(section.items, id: \.title) { item in
                    item.content()
                }
            }
        }
    }
}
