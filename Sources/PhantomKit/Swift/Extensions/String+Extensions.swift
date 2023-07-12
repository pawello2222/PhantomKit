//
//  String+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import Foundation

extension String {
    /// A Boolean value indicating whether all characters
    /// in this string represent a hexadecimal digit.
    public var isHexNumber: Bool {
        allSatisfy(\.isHexDigit)
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
}

extension String {
    private var nsString: NSString {
        self as NSString
    }
}
