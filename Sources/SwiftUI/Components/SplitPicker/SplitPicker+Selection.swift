//
//  SplitPicker+Selection.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension SplitPicker {
    struct SelectionView: View {
        @Environment(\.presentationMode) private var presentationMode
        @Environment(\.theme) private var theme
        @Binding private var selection: Selection
        private let items: [Item]
        private var showMultiLabels: Bool

        @State private var shortLabelWidth: CGFloat = 0

        init(
            selection: Binding<Selection>,
            items: [Item],
            showMultiLabels: Bool = false
        ) {
            _selection = selection
            self.items = items
            self.showMultiLabels = showMultiLabels
        }

        var body: some View {
            Form {
                ForEach(items, id: \.self) { item in
                    itemView(item: item)
                }
            }
        }
    }
}

// MARK: - Item View

extension SplitPicker.SelectionView {
    private func itemView(item: SplitPicker.Item) -> some View {
        Button(action: {
            selection = item.selection
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                if showMultiLabels {
                    itemMultiLabelView(item: item)
                } else {
                    itemLabelView(item: item)
                }
                Spacer()
                if item == items.first { $0.selection == selection } {
                    Image(system: .checkmark)
                        .font(Font.body.weight(.semibold))
                        .foregroundUIColor(theme.accentColor)
                }
            }
            .contentShape(Rectangle())
        }
    }
}

// MARK: - Item Label View

extension SplitPicker.SelectionView {
    private func itemLabelView(item: SplitPicker.Item) -> some View {
        HStack {
            Text(String(item.long))
                .foregroundUIColor(theme.textColor)
            Spacer()
        }
    }
}

extension SplitPicker.SelectionView {
    private func itemMultiLabelView(item: SplitPicker.Item) -> some View {
        HStack {
            HStack {
                Text(String(item.short))
                    .foregroundUIColor(theme.textColor)
                    .readSize {
                        shortLabelWidth = max($0.width, shortLabelWidth)
                    }
                Spacer()
            }
            .frame(maxWidth: shortLabelWidth)
            Text(String(item.long))
                .font(.subheadline)
                .foregroundUIColor(theme.textSecondaryColor)
        }
    }
}
