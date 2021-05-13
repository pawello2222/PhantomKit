//
//  PullToRefresh.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 12.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// Adapted from: https://github.com/siteline/SwiftUIRefresh
// TODO: Use the original implementation once it's fixed
public struct PullToRefresh: UIViewRepresentable {
    @Binding private var isShowing: Bool
    private let onRefresh: () -> Void

    public init(isShowing: Binding<Bool>, onRefresh: @escaping () -> Void) {
        _isShowing = isShowing
        self.onRefresh = onRefresh
    }

    public func makeUIView(context: Context) -> UIView {
        .init(frame: .zero).apply {
            $0.isHidden = true
            $0.isUserInteractionEnabled = false
        }
    }

    public func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            guard let viewHost = uiView.superview?.superview else {
                return
            }
            guard let tableView = nearestTableView(root: viewHost) else {
                return
            }
            guard let refreshControl = tableView.refreshControl else {
                tableView.refreshControl = .init().apply {
                    $0.addTarget(
                        context.coordinator,
                        action: #selector(Coordinator.onValueChanged),
                        for: .valueChanged
                    )
                }
                return
            }
            if isShowing {
                refreshControl.beginRefreshing()
            } else {
                refreshControl.endRefreshing()
            }
        }
    }

    public func makeCoordinator() -> Coordinator {
        .init(isShowing: $isShowing, onRefresh: onRefresh)
    }

    public class Coordinator {
        private let isShowing: Binding<Bool>
        private let onRefresh: () -> Void

        init(isShowing: Binding<Bool>, onRefresh: @escaping () -> Void) {
            self.isShowing = isShowing
            self.onRefresh = onRefresh
        }

        @objc func onValueChanged() {
            isShowing.wrappedValue = true
            onRefresh()
        }
    }
}

extension PullToRefresh {
    private func nearestTableView(root: UIView) -> UITableView? {
        for subview in root.subviews {
            if let tableView = subview as? UITableView {
                return tableView
            } else if let tableView = nearestTableView(root: subview) {
                return tableView
            }
        }
        return nil
    }
}

extension View {
    public func pullToRefresh(isShowing: Binding<Bool>, onRefresh: @escaping () -> Void) -> some View {
        overlay(
            PullToRefresh(isShowing: isShowing, onRefresh: onRefresh)
                .frame(0)
                // Hack: https://github.com/siteline/SwiftUIRefresh/issues/15#issuecomment-757468199
                .onChange(of: isShowing.wrappedValue) { _ in }
        )
    }
}
