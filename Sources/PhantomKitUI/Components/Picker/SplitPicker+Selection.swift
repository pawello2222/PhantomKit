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
    struct SelectionItemView: View {
        @Environment(\.shortLabelWidth) private var labelWidth
        @Environment(\.dismiss) private var dismiss

        @Binding var selection: Selection
        let item: Item
        var showMultiLabels = false

        var body: some View {
            Button {
                selection = item.selection
            } label: {
                labelView
            }
            .tint(.primary)
        }
    }
}

// MARK: - Label

extension SplitPicker.SelectionItemView {
    private var labelView: some View {
        HStack {
            if showMultiLabels {
                multiLabelView
            } else {
                singleLabelView
            }
            Spacer()
            if item.selection == selection {
                CheckmarkView()
            }
        }
        .contentShape(.rect)
    }

    private var singleLabelView: some View {
        Text(String(item.longValue))
            .foregroundStyle(.primary)
            .alignment(.leading)
    }

    private var multiLabelView: some View {
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
