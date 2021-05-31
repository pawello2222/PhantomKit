//
//  LocalizedFormatter+Precision.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 10.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

// MARK: - Precision

extension LocalizedFormatter {
    public struct Precision {
        public let minimum: Int?
        public let maximum: Int?
    }
}

extension LocalizedFormatter.Precision {
    public init() {
        minimum = nil
        maximum = nil
    }

    public init(_ range: PartialRangeFrom<Int>) {
        minimum = Self.clamp(range.lowerBound)
        maximum = nil
    }

    public init(_ range: PartialRangeThrough<Int>) {
        minimum = nil
        maximum = Self.clamp(range.upperBound)
    }

    public init(_ range: ClosedRange<Int>) {
        minimum = Self.clamp(range.lowerBound)
        maximum = Self.clamp(range.upperBound)
    }

    private static func clamp(_ value: Int) -> Int {
        value.clamped(to: .zero ... .max)
    }
}

// MARK: - Convenience

extension LocalizedFormatter.Precision {
    public static var `default`: Self {
        .init(...2)
    }

    public static var maximum: Self {
        .init(...16)
    }

    public static func constant(_ value: Int) -> Self {
        .init(value ... value)
    }
}
