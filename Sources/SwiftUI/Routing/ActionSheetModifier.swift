//
//  ActionSheetModifier.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct ActionSheetModifier: ViewModifier {
    private let trigger: PresentationMethod.Trigger
    private let content: () -> ActionSheet

    @State private var isActive = false

    public init(
        trigger: PresentationMethod.Trigger = .default,
        @ViewBuilder content: @escaping () -> ActionSheet
    ) {
        self.trigger = trigger
        self.content = content
    }

    @ViewBuilder
    public func body(content: Content) -> some View {
        content
            .modifier(PresentationTriggerModifier(trigger: trigger, isActive: $isActive))
            .actionSheet(isPresented: $isActive, content: self.content)
    }
}

// MARK: - View

extension View {
    public func actionSheet(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        @ViewBuilder content: @escaping () -> ActionSheet
    ) -> some View {
        modifier(ActionSheetModifier(trigger: trigger, content: content))
    }

    public func actionSheet(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        content: @autoclosure @escaping () -> ActionSheet
    ) -> some View {
        actionSheet(content: content)
    }
}
