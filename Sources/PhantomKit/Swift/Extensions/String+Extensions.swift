//
//  String+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import Foundation

extension String {
    public var isHexNumber: Bool {
        allSatisfy(\.isHexDigit)
    }
}

// MARK: - NSString

extension String {
    private var nsString: NSString {
        self as NSString
    }

    public var lastPathComponent: String {
        nsString.lastPathComponent
    }

    public var deletingLastPathComponent: String {
        nsString.deletingLastPathComponent
    }

    public var deletingPathExtension: String {
        nsString.deletingPathExtension
    }

    public var pathExtension: String {
        nsString.pathExtension
    }
}
