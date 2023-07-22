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

// MARK: - Convenience

extension Date {
    /// Returns a `Date` initialized from given components of a date.
    public init(
        year: Int,
        month: Int = 1,
        day: Int = 1,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        calendar: Calendar = .current
    ) {
        let dateComponents = DateComponents(
            calendar: calendar,
            timeZone: calendar.timeZone,
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            second: second
        )
        self = dateComponents.date!
    }
}

// MARK: - Adjusting

// swiftlint:disable cyclomatic_complexity
extension Date {
    /// Returns a new `Date` representing the date calculated
    /// by adjusting a given component of a date.
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

    /// Returns a new `Date` representing the date calculated
    /// by adding components to a given date in a given calendar.
    public func adjusting(
        _ components: DateComponents,
        in calendar: Calendar = .current
    ) -> Date {
        calendar.date(byAdding: components, to: self)!
    }
}
// swiftlint:enable cyclomatic_complexity

// MARK: - Components

extension Date {
    /// Returns the value for one component of a date in a given calendar.
    public func component(
        _ component: Calendar.Component,
        in calendar: Calendar = .current
    ) -> Int {
        calendar.component(component, from: self)
    }

    /// Returns all the date components of a date in a given calendar.
    public func dateComponents(
        _ components: Set<Calendar.Component>,
        in calendar: Calendar = .current
    ) -> DateComponents {
        calendar.dateComponents(components, from: self)
    }
}
