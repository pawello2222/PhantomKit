//
//  LocalizedFormatter+Sign.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 10.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import Foundation

// MARK: - Sign

extension LocalizedFormatter {
    public struct Sign {
        public let plus: Style
        public let minus: Style
        public let zero: Style

        public init(plus: Style, minus: Style, zero: Style = .none) {
            self.plus = plus
            self.minus = minus
            self.zero = zero
        }
    }
}

// MARK: - Style

extension LocalizedFormatter.Sign {
    public enum Style {
        case none
        case localized
        case custom(String)
    }
}

// MARK: - Convenience

extension LocalizedFormatter.Sign {
    public static var `default`: Self {
        .init(plus: .none, minus: .localized)
    }

    public static var both: Self {
        .init(plus: .localized, minus: .localized)
    }

    public static var none: Self {
        .init(plus: .none, minus: .none)
    }

    public static var arrow: Self {
        .init(plus: .custom("▲"), minus: .custom("▼"))
    }

    public static var spacedArrow: Self {
        .init(plus: .custom("▲ "), minus: .custom("▼ "))
    }
}
