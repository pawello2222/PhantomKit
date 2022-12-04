//
//  View+ScrollTo.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension View {
    /// Scans all scroll views contained by the proxy for the first with a child
    /// view with identifier `id`, and then scrolls to that view.
    ///
    /// If `anchor` is `nil`, this method finds the container of the identified
    /// view, and scrolls the minimum amount to make the identified view wholly
    /// visible.
    ///
    /// If `anchor` is non-`nil`, it defines the points in the identified view and
    /// the scroll view to align. For example, setting `anchor` to ``UnitPoint/top``
    /// aligns the top of the identified view to the top of the scroll view.
    /// Similarly, setting `anchor` to ``UnitPoint/bottom`` aligns the bottom of the
    /// identified view to the bottom of the scroll view, and so on.
    ///
    /// - Parameters:
    ///   - id: The identifier of a child view to scroll to.
    ///   - anchor: The alignment behavior of the scroll action.
    public func scrollTo(_ id: Binding<some Hashable>, anchor: UnitPoint = .top) -> some View {
        modifier(ScrollToViewModifier(id: id, anchor: anchor))
    }
}

// MARK: - ViewModifier

private struct ScrollToViewModifier<ID>: ViewModifier where ID: Hashable {
    @Binding fileprivate var id: ID
    fileprivate let anchor: UnitPoint

    func body(content: Content) -> some View {
        ScrollViewReader { proxy in
            content
                .onChange(of: id) { id in
                    withAnimation {
                        proxy.scrollTo(id, anchor: anchor)
                    }
                }
        }
    }
}
