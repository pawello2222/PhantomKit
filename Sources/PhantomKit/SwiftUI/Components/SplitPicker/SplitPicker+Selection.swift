// The MIT License (MIT)
//
// Copyright (c) 2021-Present Paweł Wiszenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import SwiftUI

extension SplitPicker {
    struct SelectionView: View {
        @Environment(\.shortLabelWidth) private var labelWidth
        @Environment(\.dismiss) private var dismiss

        @Binding var selection: Selection
        let items: [Item]
        var showMultiLabels = false

        var body: some View {
            Form {
                ForEach(items, id: \.self) { item in
                    itemView(item: item)
                }
            }
        }
    }
}

// MARK: - Item

extension SplitPicker.SelectionView {
    private func itemView(item: SplitPicker.Item) -> some View {
        Button {
            onSelect(item: item)
        } label: {
            labelView(item: item)
        }
        .tint(.primary)
    }
}

// MARK: - Label

extension SplitPicker.SelectionView {
    private func labelView(item: SplitPicker.Item) -> some View {
        HStack {
            if showMultiLabels {
                multiLabelView(item: item)
            } else {
                singleLabelView(item: item)
            }
            Spacer()
            checkmarkView(item: item)
        }
        .contentShape(.rect)
    }

    private func singleLabelView(item: SplitPicker.Item) -> some View {
        Text(String(item.longValue))
            .foregroundStyle(.primary)
            .alignment(.leading)
    }

    private func multiLabelView(item: SplitPicker.Item) -> some View {
        HStack {
            Text(String(item.shortValue))
                .allowsTightening(true)
                .foregroundStyle(.primary)
                .alignment(.leading)
                .frame(width: labelWidth)
            Text(String(item.longValue))
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Components

extension SplitPicker.SelectionView {
    @ViewBuilder
    private func checkmarkView(item: SplitPicker.Item) -> some View {
        if item == items.first(where: { $0.selection == selection }) {
            Image(systemName: "checkmark")
                .font(.body.weight(.semibold))
                .tint(.accentColor)
        }
    }
}

// MARK: - Action

extension SplitPicker.SelectionView {
    private func onSelect(item: SplitPicker.Item) {
        selection = item.selection
        dismiss()
    }
}
