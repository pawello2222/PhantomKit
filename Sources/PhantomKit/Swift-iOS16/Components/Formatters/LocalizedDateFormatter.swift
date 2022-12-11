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

// MARK: - Convenience

extension LocalizedDateFormatter {
    public static func date(
        locale: Locale = .current,
        format: String
    ) -> LocalizedDateFormatter {
        LocalizedDateFormatter().apply {
            $0.dateFormatter.locale = locale
            $0.dateFormatter.dateFormat = format
        }
    }

    public static func date(
        locale: Locale = .current,
        localizedFormat: String = "yyyyMMdd"
    ) -> LocalizedDateFormatter {
        LocalizedDateFormatter().apply {
            $0.dateFormatter.locale = locale
            $0.dateFormatter.setLocalizedDateFormatFromTemplate(localizedFormat)
        }
    }

    public static func dateComponents(
        locale: Locale = .current,
        allowedUnits: NSCalendar.Unit = [.hour, .minute, .second],
        unitsStyle: DateComponentsFormatter.UnitsStyle = .full
    ) -> LocalizedDateFormatter {
        LocalizedDateFormatter().apply {
            $0.dateComponentsFormatter.calendar = Calendar.current.applying {
                $0.locale = locale
            }
            $0.dateComponentsFormatter.allowedUnits = allowedUnits
            $0.dateComponentsFormatter.unitsStyle = unitsStyle
        }
    }
}

// MARK: - Format

extension LocalizedDateFormatter {
    public func date(from string: String, timeZone: TimeZone? = nil) -> Date? {
        with(timeZone: timeZone) {
            dateFormatter.date(from: string)
        }
    }
}

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

    public func string(from startDate: Date, to endDate: Date) -> String {
        dateComponentsFormatter.string(from: startDate, to: endDate) ?? invalidValueString
    }
}

// MARK: - Helpers

extension LocalizedDateFormatter {
    private func with<T>(timeZone: TimeZone?, _ block: () -> T) -> T {
        let existingTimeZone = dateFormatter.timeZone
        dateFormatter.timeZone = timeZone
        let result = block()
        dateFormatter.timeZone = existingTimeZone
        return result
    }
}

// MARK: - Convenience

extension LocalizedDateFormatter {
    public static var date = date(localizedFormat: "yyyyMMdd")

    public static var time = date(localizedFormat: "jjmmss")

    public static var datetime = date(localizedFormat: "yyyyMMddjjmmss")

    public static var dateComponents = dateComponents(
        allowedUnits: [.year, .month, .day]
    )

    public static var timeComponents = dateComponents(
        allowedUnits: [.hour, .minute, .second]
    )

    public static var datetimeComponents = dateComponents(
        allowedUnits: [.year, .month, .day, .hour, .minute, .second]
    )
}
