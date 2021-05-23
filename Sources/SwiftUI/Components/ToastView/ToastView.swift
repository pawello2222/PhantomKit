//
//  ToastView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct ToastView<Content>: View where Content: View {
    @Environment(\.appTheme) private var theme
    private let style: Style
    private let content: () -> Content

    public init(style: Style = .info, @ViewBuilder content: @escaping () -> Content) {
        self.style = style
        self.content = content
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            backgroundColor
                .ignoresSafeArea()
            content()
                .font(.app(.callout))
                .foregroundColor(textColor)
                .padding()
        }
        .fixedSize(.vertical)
        .aligned(.top)
        .transition(.move(edge: .top))
        .animation(.spring())
    }
}

// MARK: - Style

extension ToastView {
    public enum Style {
        case error
        case info
        case success
        case warning
    }
}

extension ToastView {
    private var textColor: Color {
        switch style {
        case .error:
            return theme.toastErrorColor.text
        case .info:
            return theme.toastInfoColor.text
        case .success:
            return theme.toastSuccessColor.text
        case .warning:
            return theme.toastWarningColor.text
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .error:
            return theme.toastErrorColor.background
        case .info:
            return theme.toastInfoColor.background
        case .success:
            return theme.toastSuccessColor.background
        case .warning:
            return theme.toastWarningColor.background
        }
    }
}

// MARK: - Convenience

extension ToastView where Content == Text {
    public init(_ title: String, style: Style = .info) {
        self.init(style: style) {
            Text(title)
        }
    }
}
