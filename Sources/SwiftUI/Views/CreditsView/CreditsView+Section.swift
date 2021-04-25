//
//  CreditsView+Section.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension CreditsView {
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

extension CreditsView.Section {
    struct SectionView: View {
        let section: CreditsView.Section

        var body: some View {
            VStack(spacing: .defaultPadding) {
                Text(section.title)
                    .font(.app(.subheadline, weight: .semibold))
                    .foregroundColor(.secondary)
                ForEach(section.items, id: \.title) {
                    CreditsView.Section.Item.ItemView(item: $0)
                }
            }
        }
    }
}
