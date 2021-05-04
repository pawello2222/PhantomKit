//
//  SplitPicker.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct SplitPicker<
    Label: View,
    Selection: Hashable,
    ShortValue: Hashable & LosslessStringConvertible,
    LongValue: Hashable & LosslessStringConvertible
>: View {
    public typealias Item = PickerItem<Selection, ShortValue, LongValue>

    @Environment(\.theme) private var theme
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
        HStack {
            labelView
            Spacer()
            selectedItemView
            IndicatorView()
        }
        .link(destination: selectionView)
    }

    private var labelView: some View {
        label()
            .foregroundUIColor(theme.textColor)
    }

    @ViewBuilder
    private var selectedItemView: some View {
        if let selectedItem = items.first(where: { $0.selection == selection }) {
            Text(String(selectedItem.short))
                .foregroundUIColor(theme.textSecondaryColor)
        }
    }
}

// MARK: - Selection View

extension SplitPicker {
    private var selectionView: some View {
        SelectionView(
            selection: $selection,
            items: items,
            showMultiLabels: showMultiLabels
        )
    }
}

// MARK: - Convenience

extension SplitPicker {
    public init(
        selection: Binding<Int>,
        range: ClosedRange<Int>,
        showMultiLabels: Bool = false,
        @ViewBuilder label: @escaping () -> Label
    ) where Selection == Int, ShortValue == Int, LongValue == Int {
        self.init(
            selection: selection,
            items: Array(range).map { PickerItem(selection: $0, short: $0, long: $0) },
            showMultiLabels: showMultiLabels,
            label: label
        )
    }

    public init(
        title: String,
        selection: Binding<Int>,
        range: ClosedRange<Int>,
        showMultiLabels: Bool = false
    ) where Label == Text, Selection == Int, ShortValue == Int, LongValue == Int {
        self.init(selection: selection, range: range, showMultiLabels: showMultiLabels) {
            Text(title)
        }
    }
}
