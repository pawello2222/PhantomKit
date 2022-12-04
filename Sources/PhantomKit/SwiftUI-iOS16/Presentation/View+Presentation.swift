//
//  View+Presentation.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// MARK: - Presentation

extension View {
    public func presentation(
        _ presentation: Presentation,
        onTrigger: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        route: some Route
    ) -> some View {
        modifier(
            PresentationViewModifier(
                presentation: presentation,
                onTrigger: onTrigger,
                onDismiss: onDismiss,
                route: route
            )
        )
    }
}

// MARK: - Link

extension View {
    public func link(
        triggeredBy trigger: Presentation.Trigger = .default,
        onTrigger: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        route: some Route
    ) -> some View {
        presentation(
            .link(trigger: trigger),
            onTrigger: onTrigger,
            onDismiss: onDismiss,
            route: route
        )
    }
}

// MARK: - Sheet

extension View {
    public func sheet(
        triggeredBy trigger: Presentation.Trigger = .default,
        onTrigger: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        route: some Route
    ) -> some View {
        presentation(
            .sheet(trigger: trigger),
            onTrigger: onTrigger,
            onDismiss: onDismiss,
            route: route
        )
    }
}

// MARK: - FullScreen

extension View {
    public func fullScreen(
        triggeredBy trigger: Presentation.Trigger = .default,
        onTrigger: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        route: some Route
    ) -> some View {
        presentation(
            .fullScreen(trigger: trigger),
            onTrigger: onTrigger,
            onDismiss: onDismiss,
            route: route
        )
    }
}
