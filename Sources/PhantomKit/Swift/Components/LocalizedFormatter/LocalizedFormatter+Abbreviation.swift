//
//  LocalizedFormatter+Abbreviation.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 12.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import Foundation

extension LocalizedFormatter {
    public struct Abbreviation {
        public typealias Item = (suffix: String, threshold: NSDecimalNumber)

        public let items: [Item]

        /// Items have to be in descending order - highest threshold first.
        public init(_ items: [Item] = []) {
            self.items = items
        }
    }
}

// MARK: - Computed Properties

extension LocalizedFormatter.Abbreviation {
    public var capitalized: Self {
        .init(
            items.map {
                ($0.suffix.capitalized, $0.threshold)
            }
        )
    }
}

// MARK: - Convenience

extension LocalizedFormatter.Abbreviation {
    public static var `default`: Self = .init(
        [
            ("m", 1_000_000),
            ("k", 1000),
        ]
    )

    public static var none: Self = .init()

    public static var capitalized = Self.default.capitalized
}
