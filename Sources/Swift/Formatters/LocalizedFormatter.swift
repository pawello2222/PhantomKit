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

    // Properties

    public var usesGroupingSeparator = false {
        didSet {
            formatter.usesGroupingSeparator = usesGroupingSeparator
        }
    }

    public var defaultPrecision: Precision = .default

    public var maximumAllowedFractionDigits = 16

    public var usesSignForZero = false

    public var invalidValueString = "--"

    // Computed properties

    public var decimalSeparator: String {
        formatter.decimalSeparator
    }
}

extension LocalizedFormatter {
    public static func makeCurrencyFormatter(
        locale: Locale = .current,
        currencyCode: String = Locale.current.currencyCode ?? "USD"
    ) -> LocalizedFormatter {
        LocalizedFormatter().apply {
            $0.formatter.numberStyle = .currency
            $0.formatter.locale = .init(identifier: "\(locale.identifier)@currency=\(currencyCode)")
            $0.defaultPrecision = .constant(2)
        }
    }

    public static func makeDecimalFormatter(locale: Locale = .current) -> LocalizedFormatter {
        LocalizedFormatter().apply {
            $0.formatter.numberStyle = .decimal
            $0.formatter.locale = locale
        }
    }

    public static func makePercentFormatter(locale: Locale = .current) -> LocalizedFormatter {
        LocalizedFormatter().apply {
            $0.formatter.numberStyle = .percent
            $0.formatter.locale = locale
            $0.formatter.multiplier = 1
        }
    }
}

// MARK: - Read

extension LocalizedFormatter {
    public func number(from string: String) -> NSNumber? {
        formatter.number(from: string)
    }

    public func decimalNumber(from string: String) -> NSDecimalNumber? {
        guard let number = number(from: string) else {
            return nil
        }
        return .init(decimal: number.decimalValue)
    }
}

// MARK: - Format

extension LocalizedFormatter {
    public func string(
        from value: Int,
        abbreviation: Abbreviation = .none,
        sign: Sign = .default,
        precision: Precision? = nil
    ) -> String {
        string(from: NSDecimalNumber(value: value), abbreviation: abbreviation, sign: sign, precision: precision)
    }

    public func string(
        from value: Float,
        abbreviation: Abbreviation = .none,
        sign: Sign = .default,
        precision: Precision? = nil
    ) -> String {
        string(from: NSDecimalNumber(value: value), abbreviation: abbreviation, sign: sign, precision: precision)
    }

    public func string(
        from value: Double,
        abbreviation: Abbreviation = .none,
        sign: Sign = .default,
        precision: Precision? = nil
    ) -> String {
        string(from: NSDecimalNumber(value: value), abbreviation: abbreviation, sign: sign, precision: precision)
    }

    public func string(
        from value: Decimal,
        abbreviation: Abbreviation = .none,
        sign: Sign = .default,
        precision: Precision? = nil
    ) -> String {
        string(from: NSDecimalNumber(decimal: value), abbreviation: abbreviation, sign: sign, precision: precision)
    }

    public func string(
        from value: NSDecimalNumber,
        abbreviation: Abbreviation = .none,
        sign: Sign = .default,
        precision: Precision? = nil
    ) -> String {
        var roundedValue = value
        if let places = precision?.maximum ?? defaultPrecision.maximum {
            roundedValue = value.rounded(toPlaces: places)
        }
        guard roundedValue != .zero else {
            if usesSignForZero {
                return with(zeroSign: sign.zero) {
                    string(from: roundedValue)
                }
            } else {
                return string(from: roundedValue)
            }
        }
        return with(sign: sign) {
            with(precision: precision) {
                abbreviatedString(from: value, abbreviation: abbreviation)
            }
        }
    }

    private func abbreviatedString(from value: NSDecimalNumber, abbreviation: Abbreviation) -> String {
        for (suffix, threshold) in abbreviation.items where value >= threshold {
            return with(abbreviationSuffix: suffix) {
                string(from: value / threshold)
            }
        }
        return string(from: value)
    }

    private func string(from value: NSDecimalNumber) -> String {
        formatter.string(from: value) ?? invalidValueString
    }
}

// MARK: - Helpers

extension LocalizedFormatter {
    private func with<T>(abbreviationSuffix: String, _ block: () -> T) -> T {
        let existingPositiveSuffix = formatter.positiveSuffix
        let existingNegativeSuffix = formatter.negativeSuffix
        formatter.positiveSuffix = abbreviationSuffix + formatter.positiveSuffix
        formatter.negativeSuffix = abbreviationSuffix + formatter.negativeSuffix
        let result = block()
        formatter.positiveSuffix = existingPositiveSuffix
        formatter.negativeSuffix = existingNegativeSuffix
        return result
    }

    private func with<T>(precision: Precision?, _ block: () -> T) -> T {
        let existingMinimumFractionDigits = formatter.minimumFractionDigits
        let existingMaximumFractionDigits = formatter.maximumFractionDigits
        let precision = precision ?? defaultPrecision
        formatter.minimumFractionDigits = precision.minimum ?? 0
        formatter.maximumFractionDigits = precision.maximum ?? maximumAllowedFractionDigits
        let result = block()
        formatter.minimumFractionDigits = existingMinimumFractionDigits
        formatter.maximumFractionDigits = existingMaximumFractionDigits
        return result
    }

    private func with<T>(sign: Sign, _ block: () -> T) -> T {
        let existingPositivePrefix = formatter.positivePrefix
        let existingNegativePrefix = formatter.negativePrefix

        var newPlusSign: String!
        switch sign.plus {
        case .none:
            newPlusSign = ""
        case .localized:
            newPlusSign = formatter.plusSign
        case .custom(let plusSign):
            newPlusSign = plusSign
        }
        if formatter.positivePrefix.contains(formatter.plusSign) {
            formatter.positivePrefix = formatter.positivePrefix
                .replacingOccurrences(of: formatter.plusSign, with: newPlusSign)
        } else {
            formatter.positivePrefix = newPlusSign + formatter.positivePrefix
        }

        var newMinusSign: String!
        switch sign.minus {
        case .none:
            newMinusSign = ""
        case .localized:
            newMinusSign = formatter.minusSign
        case .custom(let minusSign):
            newMinusSign = minusSign
        }
        if formatter.negativePrefix.contains(formatter.minusSign) {
            formatter.negativePrefix = formatter.negativePrefix
                .replacingOccurrences(of: formatter.minusSign, with: newMinusSign)
        } else {
            formatter.negativePrefix = newMinusSign + formatter.negativePrefix
        }

        let result = block()

        formatter.positivePrefix = existingPositivePrefix
        formatter.negativePrefix = existingNegativePrefix
        return result
    }

    private func with<T>(zeroSign: Sign.Style, _ block: () -> T) -> T {
        let existingPositivePrefix = formatter.positivePrefix

        var newZeroSign: String!
        switch zeroSign {
        case .custom(let zeroSign):
            newZeroSign = zeroSign
        default:
            newZeroSign = ""
        }
        formatter.positivePrefix = newZeroSign + formatter.positivePrefix

        let result = block()

        formatter.positivePrefix = existingPositivePrefix
        return result
    }
}

// MARK: - Convenience

extension LocalizedFormatter {
    public static var currency = makeCurrencyFormatter()

    public static var decimal = makeDecimalFormatter()

    public static var percent = makePercentFormatter()
}
