//
//  Date+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 19/06/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

import Foundation

extension Date {
    /// Convenient initializer to create a `Date` object.
    ///
    /// - Parameters:
    ///   - year: Year to set on the Date.
    ///   - month: Month to set on the Date.
    ///   - day: Date to set on the Date.
    ///   - hour: Hour to set on the Date.
    ///   - minute: Minute to set on the Date.
    ///   - second: Second to set on the Date.
    ///   - calendar: Calendar to set on the Date.
    public init(
        year: Int,
        month: Int = 1,
        day: Int = 1,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        calendar: Calendar = .current
    ) {
        let dateComponent = DateComponents(
            calendar: calendar,
            timeZone: calendar.timeZone,
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            second: second
        )

        self = dateComponent.date!
    }
}

extension Date {
    /// Adjusts the receiver's given component by the given offset in set calendar.
    ///
    /// - Parameters:
    ///   - component: Component to adjust.
    ///   - offset: Offset to use for adjustment.
    ///   - calendar: The calendar to use for adjustment.
    public func adjusting(_ component: Calendar.Component, by offset: Int, in calendar: Calendar = .current) -> Date {
        var dateComponent = DateComponents()

        switch component {
        case .nanosecond:
            dateComponent.nanosecond = offset
        case .second:
            dateComponent.second = offset
        case .minute:
            dateComponent.minute = offset
        case .hour:
            dateComponent.hour = offset
        case .day:
            dateComponent.day = offset
        case .weekday:
            dateComponent.weekday = offset
        case .weekdayOrdinal:
            dateComponent.weekdayOrdinal = offset
        case .weekOfYear:
            dateComponent.weekOfYear = offset
        case .month:
            dateComponent.month = offset
        case .year:
            dateComponent.year = offset
        case .era:
            dateComponent.era = offset
        case .quarter:
            dateComponent.quarter = offset
        case .weekOfMonth:
            dateComponent.weekOfMonth = offset
        case .yearForWeekOfYear:
            dateComponent.yearForWeekOfYear = offset
        case .calendar, .timeZone, .isLeapMonth:
            fatalError("Unsupported type \(component)")
        @unknown default:
            fatalError("Unsupported type \(component)")
        }

        return adjusting(dateComponent, in: calendar)
    }

    /// Adjusts the receiver by given date components.
    ///
    /// - Parameters:
    ///   - components: DateComponents object that contains adjustment values.
    ///   - calendar: The calendar to use for adjustment.
    public func adjusting(_ components: DateComponents, in calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: components, to: self)!
    }

    /// Retrieves the receiver's given component value.
    ///
    /// - Parameters:
    ///   - component: Component to get the value for.
    ///   - calendar: The calendar to use for retrieval.
    ///
    /// **Usage**
    ///
    /// ```swift
    /// let date = Date(year: 2020, month: 2, day: 1, hour: 3, minute: 41, second: 22)
    ///
    /// // Example in default calendar
    /// let year = date.component(.year)
    /// let month = date.component(.month)
    /// let day = date.component(.day)
    ///
    /// print(year)  // 2020
    /// print(month) // 2
    /// print(day)   // 1
    ///
    /// // Example in different calendar
    /// let year = date.component(.year, in: .usEastern)
    /// let month = date.component(.month, in: .usEastern)
    /// let day = date.component(.day, in: .usEastern)
    /// let hour = date.component(.hour, in: .usEastern)
    ///
    /// print(year)  // 2020
    /// print(month) // 1
    /// print(day)   // 31
    /// print(hour)  // 22
    /// ```
    public func component(_ component: Calendar.Component, in calendar: Calendar = .current) -> Int {
        calendar.component(component, from: self)
    }
}

extension Date {
    public func dateComponents(
        _ components: Set<Calendar.Component>,
        in calendar: Calendar = .current
    ) -> DateComponents {
        calendar.dateComponents(components, from: self)
    }
}

extension Date {
    public func localizedString(formatter: LocalizedDateFormatter = .date) -> String {
        formatter.string(from: self)
    }
}
