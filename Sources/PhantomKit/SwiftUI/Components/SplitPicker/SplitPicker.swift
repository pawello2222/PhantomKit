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

public struct SplitPicker<
    Label: View,
    Selection: Hashable,
    ShortValue: Hashable & LosslessStringConvertible,
    LongValue: Hashable & LosslessStringConvertible
>: View {
    public typealias Item = PickerItem<Selection, ShortValue, LongValue>

    @Binding private var selection: Selection
    private let items: [Item]
    private var showMultiLabels: Bool
    private let label: () -> Label

    public init(
        selection: Binding<Selection>,
        items: [Item],
        showMultiLabels: Bool = false,
        @ViewBuilder label: @escaping () -> Label
    ) {
        _selection = selection
        self.items = items
        self.showMultiLabels = showMultiLabels
        self.label = label
    }

    public var body: some View {
        NavigationLink {
            selectionView
        } label: {
            contentView
        }
    }
}

// MARK: - Content

extension SplitPicker {
    private var contentView: some View {
        HStack {
            labelView
            Spacer()
            shortValueView
        }
    }

    private var labelView: some View {
        label()
            .foregroundStyle(.primary)
    }

    @ViewBuilder
    private var shortValueView: some View {
        if let selectedItem = items.first(where: { $0.selection == selection }) {
            Text(String(selectedItem.shortValue))
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Selection

extension SplitPicker {
    private var selectionView: some View {
        Form {
            ForEach(items, id: \.self) { item in
                SelectionItemView(
                    selection: $selection,
                    item: item,
                    showMultiLabels: showMultiLabels
                )
            }
        }
    }
}

// MARK: - Convenience

extension SplitPicker {
    public init(
        title: LocalizedStringResource,
        selection: Binding<Selection>,
        items: [Item],
        showMultiLabels: Bool = false
    ) where Label == Text {
        self.init(
            selection: selection,
            items: items,
            showMultiLabels: showMultiLabels
        ) {
            Text(title)
        }
    }

    public init(
        selection: Binding<Int>,
        range: ClosedRange<Int>,
        showMultiLabels: Bool = false,
        @ViewBuilder label: @escaping () -> Label
    ) where Selection == Int, ShortValue == Int, LongValue == Int {
        self.init(
            selection: selection,
            items: Array(range).map {
                PickerItem(selection: $0, shortValue: $0, longValue: $0)
            },
            showMultiLabels: showMultiLabels,
            label: label
        )
    }

    public init(
        title: LocalizedStringResource,
        selection: Binding<Int>,
        range: ClosedRange<Int>,
        showMultiLabels: Bool = false
    ) where Label == Text, Selection == Int, ShortValue == Int, LongValue == Int {
        self.init(
            selection: selection,
            range: range,
            showMultiLabels: showMultiLabels
        ) {
            Text(title)
        }
    }
}
