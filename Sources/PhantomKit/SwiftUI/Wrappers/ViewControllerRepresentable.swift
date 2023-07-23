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
#if os(iOS) || os(tvOS)
public typealias PlatformViewController = UIViewController
public typealias PlatformViewControllerRepresentable = UIViewControllerRepresentable
#elseif os(macOS)
public typealias PlatformViewController = NSViewController
public typealias PlatformViewControllerRepresentable = NSViewControllerRepresentable
#endif

/// Adds `UIViewControllerRepresentable` conformance on iOS
/// and `NSViewControllerRepresentable` conformance on macOS.
public protocol ViewControllerRepresentable: PlatformViewControllerRepresentable {
    associatedtype PlatformViewControllerType
    func makeViewController(context: Context) -> PlatformViewControllerType
    func updateViewController(_ viewController: PlatformViewControllerType, context: Context)
}

// MARK: - Platform

#if os(iOS) || os(tvOS)
extension ViewControllerRepresentable where UIViewControllerType == PlatformViewControllerType {
    public func makeUIViewController(context: Context) -> UIViewControllerType {
        makeViewController(context: context)
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        updateViewController(uiViewController, context: context)
    }
}

#elseif os(macOS)
extension ViewControllerRepresentable where NSViewControllerType == PlatformViewControllerType {
    public func makeNSViewController(context: Context) -> NSViewControllerType {
        makeViewController(context: context)
    }

    public func updateNSViewController(_ nsViewController: NSViewControllerType, context: Context) {
        updateViewController(nsViewController, context: context)
    }
}
#endif
