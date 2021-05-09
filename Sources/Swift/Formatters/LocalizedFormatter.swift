//
//  LocalizedFormatter.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 09.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

public class LocalizedFormatter: Appliable {
    public init() {}

    private lazy var formatter = NumberFormatter()

    public var usesGroupingSeparator = false {
        didSet {
            formatter.usesGroupingSeparator = usesGroupingSeparator
        }
    }

    public var invalidValueString = "--"
}

// MARK: - Convenience

extension LocalizedFormatter {
    public static var currency = makeCurrencyFormatter()

    public static var decimal = makeDecimalFormatter()

    public static var percent = makePercentFormatter()
}

extension LocalizedFormatter {
    public static func makeCurrencyFormatter(
        locale: Locale = .current,
        currencyCode: String = Locale.current.currencyCode ?? "USD"
    ) -> LocalizedFormatter {
        .init().apply {
            $0.formatter.numberStyle = .currency
            $0.formatter.locale = .init(identifier: "\(locale.identifier)@currency=\(currencyCode)")
        }
    }

    public static func makeDecimalFormatter(locale: Locale = .current) -> LocalizedFormatter {
        .init().apply {
            $0.formatter.numberStyle = .decimal
            $0.formatter.maximumFractionDigits = 2
        }
    }

    public static func makePercentFormatter(locale: Locale = .current) -> LocalizedFormatter {
        .init().apply {
            $0.formatter.numberStyle = .percent
            $0.formatter.locale = locale
            $0.formatter.maximumFractionDigits = 2
            $0.formatter.multiplier = 1
        }
    }
}

// MARK: - Abbreviation

extension LocalizedFormatter {
    public enum Abbreviation: String {
        case thousand = "k"
        case million = "m"
    }
}

// MARK: - Format

extension LocalizedFormatter {
    public func string(
        from value: Int,
        abbreviated: Bool = false,
        signed: Bool = false
    ) -> String {
        string(from: NSDecimalNumber(value: value), abbreviated: abbreviated, signed: signed)
    }

    public func string(
        from value: Float,
        abbreviated: Bool = false,
        signed: Bool = false
    ) -> String {
        string(from: NSDecimalNumber(value: value), abbreviated: abbreviated, signed: signed)
    }

    public func string(
        from value: Double,
        abbreviated: Bool = false,
        signed: Bool = false
    ) -> String {
        string(from: NSDecimalNumber(value: value), abbreviated: abbreviated, signed: signed)
    }

    public func string(
        from value: Decimal,
        abbreviated: Bool = false,
        signed: Bool = false
    ) -> String {
        string(from: NSDecimalNumber(decimal: value), abbreviated: abbreviated, signed: signed)
    }

    public func string(
        from value: NSDecimalNumber,
        abbreviated: Bool = false,
        signed: Bool = false
    ) -> String {
        with(plusSign: signed ? formatter.plusSign : "") {
            abbreviated ? abbreviatedString(from: value) : string(from: value)
        }
    }
}

extension LocalizedFormatter {
    private func abbreviatedString(from value: NSDecimalNumber) -> String {
        switch abs(value.decimalValue) {
        case 1_000_000...:
            return with(abbreviation: .million) {
                string(from: value / 1_000_000)
            }
        case 1000...:
            return with(abbreviation: .thousand) {
                string(from: value / 1000)
            }
        default:
            return string(from: value)
        }
    }

    private func string(from value: NSDecimalNumber) -> String {
        formatter.string(from: value) ?? invalidValueString
    }
}

// MARK: - Helpers

extension LocalizedFormatter {
    private func with<T>(abbreviation: Abbreviation, _ block: () -> T) -> T {
        let existingPositiveSuffix = formatter.positiveSuffix
        let existingNegativeSuffix = formatter.negativeSuffix
        formatter.positiveSuffix = abbreviation.rawValue + formatter.positiveSuffix
        formatter.negativeSuffix = abbreviation.rawValue + formatter.negativeSuffix
        let result = block()
        formatter.positiveSuffix = existingPositiveSuffix
        formatter.negativeSuffix = existingNegativeSuffix
        return result
    }

    private func with<T>(plusSign: String, _ block: () -> T) -> T {
        let existingPositivePrefix = formatter.positivePrefix
        formatter.positivePrefix = plusSign + formatter.positiveSuffix
        let result = block()
        formatter.positivePrefix = existingPositivePrefix
        return result
    }
}
