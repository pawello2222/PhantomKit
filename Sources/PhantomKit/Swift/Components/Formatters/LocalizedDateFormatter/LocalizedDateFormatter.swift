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

import Appliable
import Foundation

public typealias XDateFormatter = LocalizedDateFormatter

/// A formatter that converts between dates and their textual representations.
public class LocalizedDateFormatter: ObjectAppliable {
    // MARK: Public Properties

    public var invalidValueString = "--"

    // MARK: Private Properties

    private lazy var dateFormatter = DateFormatter()
    private lazy var dateComponentsFormatter = DateComponentsFormatter()

    // MARK: Initialization

    public init() {}
}

// MARK: - Format to Date

extension LocalizedDateFormatter {
    public func date(from string: String, timeZone: TimeZone? = nil) -> Date? {
        with(timeZone: timeZone) {
            dateFormatter.date(from: string)
        }
    }
}

// MARK: - Format to String

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

// MARK: - Date

extension Date {
    public func localizedString(formatter: LocalizedDateFormatter = .date) -> String {
        formatter.string(from: self)
    }
}
