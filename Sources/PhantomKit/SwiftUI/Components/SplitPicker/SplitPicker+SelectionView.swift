//
//  SplitPicker+SelectionView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension SplitPicker {
    struct SelectionView: View {
        @Environment(\.appTheme) private var theme
        @Environment(\.defaultShortLabelWidth) private var labelWidth
        @Environment(\.dismiss) private var dismiss
        @Binding private var selection: Selection
        private let items: [Item]
        private var showMultiLabels: Bool

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
        Button {
            selection = item.selection
            dismiss()
        } label: {
            HStack {
                if showMultiLabels {
                    itemMultiLabelView(item: item)
                } else {
                    itemLabelView(item: item)
                }
                Spacer()
                if item == items.first(where: \.selection, equals: selection) {
                    Image(system: .checkmark)
                        .font(Font.body.weight(.semibold))
                        .foregroundColor(theme.accentColor)
                }
            }
            .contentShape(Rectangle())
        }
    }
}

// MARK: - Item Label View

extension SplitPicker.SelectionView {
    private func itemLabelView(item: SplitPicker.Item) -> some View {
        Text(String(item.long))
            .foregroundColor(theme.primaryColor)
            .aligned(.leading)
    }
}

extension SplitPicker.SelectionView {
    private func itemMultiLabelView(item: SplitPicker.Item) -> some View {
        HStack {
            Text(String(item.short))
                .allowsTightening(true)
                .foregroundColor(theme.primaryColor)
                .aligned(.leading)
                .frame(width: labelWidth)
            Text(String(item.long))
                .font(.subheadline)
                .foregroundColor(theme.secondaryColor)
        }
    }
}
