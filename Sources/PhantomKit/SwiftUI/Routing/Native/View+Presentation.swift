//
//  View+Presentation.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension View {
    public func presentation<Content>(
        method: PresentationMethod,
        onTrigger: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        modifier(
            PresentationModifier(
                method: method,
                onTrigger: onTrigger,
                onDismiss: onDismiss,
                content: content
            )
        )
    }
}

// MARK: - Link

extension View {
    public func link<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        onTrigger: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder destination: @escaping () -> Content
    ) -> some View where Content: View {
        presentation(
            method: .link(trigger: trigger),
            onTrigger: onTrigger,
            onDismiss: onDismiss,
            content: destination
        )
    }

    public func link<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        onTrigger: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        destination: @autoclosure @escaping () -> Content
    ) -> some View where Content: View {
        link(triggeredBy: trigger, onTrigger: onTrigger, onDismiss: onDismiss, destination: destination)
    }
}

// MARK: - Sheet

extension View {
    public func sheet<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        onTrigger: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        presentation(
            method: .sheet(trigger: trigger),
            onTrigger: onTrigger,
            onDismiss: onDismiss,
            content: content
        )
    }

    public func sheet<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        onTrigger: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        content: @autoclosure @escaping () -> Content
    ) -> some View where Content: View {
        sheet(triggeredBy: trigger, onTrigger: onTrigger, onDismiss: onDismiss, content: content)
    }
}

// MARK: - Full Screen

extension View {
    public func fullScreen<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        onTrigger: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        presentation(
            method: .fullScreen(trigger: trigger),
            onTrigger: onTrigger,
            onDismiss: onDismiss,
            content: content
        )
    }

    public func fullScreen<Content>(
        triggeredBy trigger: PresentationMethod.Trigger = .default,
        onTrigger: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        content: @autoclosure @escaping () -> Content
    ) -> some View where Content: View {
        fullScreen(triggeredBy: trigger, onTrigger: onTrigger, onDismiss: onDismiss, content: content)
    }
}

// MARK: - Web View

extension View {
    public func webView(
        openedAs method: PresentationMethod = .sheet,
        endpoint: WebEndpoint,
        edgesIgnoringSafeArea: Edge.Set = .none,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        presentation(method: method, onDismiss: onDismiss) {
            WebView(endpoint: endpoint)
                .edgesIgnoringSafeArea(edgesIgnoringSafeArea)
                .applyIf(method.isModal) {
                    $0.embedInNavigation()
                }
        }
    }

    public func webView(
        triggeredBy trigger: PresentationMethod.Trigger,
        endpoint: WebEndpoint,
        edgesIgnoringSafeArea: Edge.Set = .none,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        webView(
            openedAs: .sheet(trigger: trigger),
            endpoint: endpoint,
            edgesIgnoringSafeArea: edgesIgnoringSafeArea,
            onDismiss: onDismiss
        )
    }
}
