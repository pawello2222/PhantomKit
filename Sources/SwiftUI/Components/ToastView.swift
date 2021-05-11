//
//  ToastView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct ToastView<Content>: View where Content: View {
    @Environment(\.theme) private var theme
    private let style: Style
    private let content: () -> Content

    public init(style: Style = .info, @ViewBuilder content: @escaping () -> Content) {
        self.style = style
        self.content = content
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            Color(backgroundColor)
                .ignoresSafeArea()
            content()
                .font(.app(.callout, weight: .medium))
                .foregroundUIColor(textColor)
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
    private var textColor: UIColor {
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

    private var backgroundColor: UIColor {
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
    public init(text: String, style: Style = .info) {
        self.init(style: style) {
            Text(text)
        }
    }
}

// MARK: - Theme

public typealias ToastColorConfiguration = (text: UIColor, background: UIColor)

extension Theme {
    public var toastErrorColor: ToastColorConfiguration {
        get { userInfo[.toastErrorColor] as? ToastColorConfiguration ?? (text: .white, background: .systemRed) }
        set { userInfo[.toastErrorColor] = newValue }
    }

    public var toastInfoColor: ToastColorConfiguration {
        get { userInfo[.toastInfoColor] as? ToastColorConfiguration ?? (text: .white, background: .systemBlue) }
        set { userInfo[.toastInfoColor] = newValue }
    }

    public var toastSuccessColor: ToastColorConfiguration {
        get { userInfo[.toastSuccessColor] as? ToastColorConfiguration ?? (text: .white, background: .systemGreen) }
        set { userInfo[.toastSuccessColor] = newValue }
    }

    public var toastWarningColor: ToastColorConfiguration {
        get { userInfo[.toastWarningColor] as? ToastColorConfiguration ?? (text: .black, background: .systemYellow) }
        set { userInfo[.toastWarningColor] = newValue }
    }
}

// MARK: - UserInfo

extension UserInfoKey where Type == Theme {
    public static var toastErrorColor: Self { #function }
    public static var toastInfoColor: Self { #function }
    public static var toastSuccessColor: Self { #function }
    public static var toastWarningColor: Self { #function }
}
