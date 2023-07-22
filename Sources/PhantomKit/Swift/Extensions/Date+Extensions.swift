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
    public func adjusting(
        _ component: Calendar.Component,
        by offset: Int,
        in calendar: Calendar = .current
    ) -> Date {
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
        default:
            return self
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
