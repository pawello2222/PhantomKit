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

import Foundation

// MARK: - Convenience

extension String {
    /// Returns `self` as `NSString`
    public var nsString: NSString {
        self as NSString
    }
}

// MARK: - Helpers

extension String {
    /// A copy of the string with the first letter capitalized.
    public var capitalizedFirst: String {
        prefix(1).capitalized + dropFirst()
    }

    /// A Boolean value indicating whether all characters
    /// in this string represent a hexadecimal digit.
    public var isHexNumber: Bool {
        allSatisfy(\.isHexDigit)
    }

    /// Returns a new string created by replacing all characters in the string not
    /// in the specified set with percent encoded characters.
    ///
    /// The default value is `.urlQueryAllowed`.
    ///
    /// - Parameter allowedCharacters: The allowed character set.
    public func urlEscaped(allowed allowedCharacters: CharacterSet = .urlQueryAllowed) -> String? {
        addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
}

// MARK: - NSString

extension String {
    /// The last path component of the receiver.
    public var lastPathComponent: String {
        nsString.lastPathComponent
    }

    /// A new string made by deleting the last path component
    /// from the receiver, along with any final path separator.
    public var deletingLastPathComponent: String {
        nsString.deletingLastPathComponent
    }

    /// A new string made by deleting the extension
    /// (if any, and only the last) from the receiver.
    public var deletingPathExtension: String {
        nsString.deletingPathExtension
    }

    /// The path extension, if any, of the string as interpreted
    /// as a path.
    public var pathExtension: String {
        nsString.pathExtension
    }

    /// Returns a new string made by appending to the receiver a given string.
    public func appendingPathComponent(_ component: Any?) -> String {
        guard let component else {
            return self
        }
        return nsString.appendingPathComponent(String(describing: component))
    }
}
