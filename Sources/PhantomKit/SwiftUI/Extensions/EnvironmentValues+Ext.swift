//
//  EnvironmentValues+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 18.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

// MARK: - AppTheme

extension EnvironmentValues {
    private struct AppThemeKey: EnvironmentKey {
        static var defaultValue: AppTheme = .default
    }

    public var appTheme: AppTheme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}

// MARK: - DefaultIconHeight

extension EnvironmentValues {
    private struct DefaultIconHeightKey: EnvironmentKey {
        static var defaultValue: CGFloat = 32
    }

    public var defaultIconHeight: CGFloat {
        get { self[DefaultIconHeightKey.self] }
        set { self[DefaultIconHeightKey.self] = newValue }
    }
}

// MARK: - DefaultShortLabelWidth

extension EnvironmentValues {
    private struct DefaultShortLabelWidthKey: EnvironmentKey {
        static var defaultValue: CGFloat = 50
    }

    public var defaultShortLabelWidth: CGFloat {
        get { self[DefaultShortLabelWidthKey.self] }
        set { self[DefaultShortLabelWidthKey.self] = newValue }
    }
}

// MARK: - GeometrySize

extension EnvironmentValues {
    private struct GeometrySizeKey: EnvironmentKey {
        static let defaultValue: CGSize = .zero
    }

    public var geometrySize: CGSize {
        get { self[GeometrySizeKey] }
        set { self[GeometrySizeKey] = newValue }
    }
}

// MARK: - TabSelection

extension EnvironmentValues {
    private struct TabSelectionKey: EnvironmentKey {
        static var defaultValue: AnyHashable?
    }

    public var tabSelection: AnyHashable? {
        get { self[TabSelectionKey.self] }
        set { self[TabSelectionKey.self] = newValue }
    }
}

// MARK: - View Helpers

extension View {
    public func appTheme(_ appTheme: AppTheme) -> some View {
        environment(\.appTheme, appTheme)
    }

    public func defaultIconHeight(_ value: CGFloat) -> some View {
        environment(\.defaultIconHeight, value)
    }

    public func defaultShortLabelWidth(_ value: CGFloat) -> some View {
        environment(\.defaultShortLabelWidth, value)
    }

    public func geometrySize(_ size: CGSize) -> some View {
        environment(\.geometrySize, size)
    }

    public func tabSelection<Selection>(_ selection: Selection) -> some View where Selection: Hashable {
        environment(\.tabSelection, selection)
    }

    public func tabSelection<Selection>(_ selection: Binding<Selection>) -> some View where Selection: Hashable {
        tabSelection(selection.wrappedValue)
    }
}
