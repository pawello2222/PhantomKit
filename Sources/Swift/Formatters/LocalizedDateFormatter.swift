//
//  LocalizedDateFormatter.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 09.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

public class LocalizedDateFormatter: Appliable {
    public init() {}

    private lazy var dateFormatter = DateFormatter()
    private lazy var dateComponentsFormatter = DateComponentsFormatter()

    public var invalidValueString = "--"
}

extension LocalizedDateFormatter {
    public static func makeDateFormatter(
        locale: Locale = .current,
        format: String
    ) -> LocalizedDateFormatter {
        .init().apply {
            $0.dateFormatter.locale = locale
            $0.dateFormatter.dateFormat = format
        }
    }

    public static func makeDateFormatter(
        locale: Locale = .current,
        localizedFormat: String = "yyyyMMdd"
    ) -> LocalizedDateFormatter {
        .init().apply {
            $0.dateFormatter.locale = locale
            $0.dateFormatter.setLocalizedDateFormatFromTemplate(localizedFormat)
        }
    }
}

extension LocalizedDateFormatter {
    public static func makeDateComponentsFormatter(
        locale: Locale = .current,
        allowedUnits: NSCalendar.Unit = [.hour, .minute, .second],
        unitsStyle: DateComponentsFormatter.UnitsStyle = .full
    ) -> LocalizedDateFormatter {
        .init().apply {
            $0.dateComponentsFormatter.calendar = .current.applying {
                $0.locale = locale
            }
            $0.dateComponentsFormatter.allowedUnits = allowedUnits
            $0.dateComponentsFormatter.unitsStyle = unitsStyle
        }
    }
}

// MARK: - Format

extension LocalizedDateFormatter {
    public func string(from date: Date) -> String {
        dateFormatter.string(from: date)
    }
}

extension LocalizedDateFormatter {
    public func string(from dateComponents: DateComponents) -> String {
        dateComponentsFormatter.string(from: dateComponents) ?? invalidValueString
    }

    public func string(from ti: TimeInterval) -> String {
        dateComponentsFormatter.string(from: ti) ?? invalidValueString
    }
}

// MARK: - Convenience

extension LocalizedDateFormatter {
    public static var date = makeDateFormatter()

    public static var datetime = makeDateFormatter(localizedFormat: "yyyyMMddjjmmss")

    public static var dateComponents = makeDateComponentsFormatter()
}
