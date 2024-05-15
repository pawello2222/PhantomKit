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

#if os(macOS)
/// A set of values that indicate the visual size available to the view.
public enum UserInterfaceSizeClass {
    case compact
    case regular
}

// MARK: - HorizontalSizeClass

extension EnvironmentValues {
    private struct HorizontalSizeClassEnvironmentKey: EnvironmentKey {
        static let defaultValue: UserInterfaceSizeClass = .regular
    }

    /// The horizontal size class of this environment.
    public var horizontalSizeClass: UserInterfaceSizeClass {
        get { self[HorizontalSizeClassEnvironmentKey.self] }
        set { self[HorizontalSizeClassEnvironmentKey.self] = newValue }
    }
}

// MARK: - VerticalSizeClass

extension EnvironmentValues {
    private struct VerticalSizeClassEnvironmentKey: EnvironmentKey {
        static let defaultValue: UserInterfaceSizeClass = .regular
    }

    /// The vertical size class of this environment.
    public var verticalSizeClass: UserInterfaceSizeClass {
        get { self[VerticalSizeClassEnvironmentKey.self] }
        set { self[VerticalSizeClassEnvironmentKey.self] = newValue }
    }
}
#endif
