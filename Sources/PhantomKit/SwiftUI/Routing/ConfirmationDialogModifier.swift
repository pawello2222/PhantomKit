//
//  ConfirmationDialogModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 17.10.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct ConfirmationDialogModifier<
    Title: StringProtocol,
    Actions: View,
    Message: View
>: ViewModifier {
    private let trigger: PresentationMethod.Trigger
    private let onTrigger: (() -> Void)?
    private let title: Title
    private let titleVisibility: Visibility
    private let actions: () -> Actions
    private let message: () -> Message

    @State private var isActive = false

    public init(
        trigger: PresentationMethod.Trigger = .default,
        title: Title,
        titleVisibility: Visibility = .visible,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder message: @escaping () -> Message,
        onTrigger: (() -> Void)? = nil
    ) {
        self.trigger = trigger
        self.title = title
        self.titleVisibility = titleVisibility
        self.actions = actions
        self.message = message
        self.onTrigger = onTrigger
    }

    @ViewBuilder
    public func body(content: Content) -> some View {
        content
            .modifier(PresentationTriggerModifier(trigger: trigger, isActive: $isActive, onTrigger: onTrigger))
            .confirmationDialog(
                title,
                isPresented: $isActive,
                titleVisibility: titleVisibility,
                actions: actions,
                message: message
            )
    }
}

// MARK: - View

extension View {
    public func confirmationDialog<S, A, M>(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        title: S,
        titleVisibility: Visibility = .visible,
        @ViewBuilder actions: @escaping () -> A,
        @ViewBuilder message: @escaping () -> M,
        onTrigger: (() -> Void)? = nil
    ) -> some View where S: StringProtocol, A: View, M: View {
        modifier(ConfirmationDialogModifier(
            trigger: trigger,
            title: title,
            titleVisibility: titleVisibility,
            actions: actions,
            message: message,
            onTrigger: onTrigger
        ))
    }

    public func confirmationDialog<S, A>(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        title: S,
        titleVisibility: Visibility = .visible,
        @ViewBuilder actions: @escaping () -> A,
        onTrigger: (() -> Void)? = nil
    ) -> some View where S: StringProtocol, A: View {
        modifier(ConfirmationDialogModifier(
            trigger: trigger,
            title: title,
            titleVisibility: titleVisibility,
            actions: actions,
            message: {
                EmptyView()
            },
            onTrigger: onTrigger
        ))
    }
}
