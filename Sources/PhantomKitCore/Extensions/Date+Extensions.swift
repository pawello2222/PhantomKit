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

// MARK: - Adjustment

extension Date {
    /// Returns a new `Date` representing the date calculated
    /// by adjusting a given component of a date.
    public func adjusting(
        _ component: WritableKeyPath<DateComponents, Int?>,
        by offset: Int,
        in calendar: Calendar = .current
    ) -> Date {
        var components = DateComponents()
        components[keyPath: component] = offset
        return calendar.date(byAdding: components, to: self)!
    }

    /// Returns a new `Date` representing the date calculated
    /// by adjusting to the start of a given component of a date.
    public func startOf(
        _ component: Calendar.Component,
        in calendar: Calendar = .current
    ) -> Date {
        // Incompatible components: `calendar`, `timeZone`, `isLeapMonth`
        #if DEBUG
        calendar.dateInterval(of: component, for: self)!.start
        #else
        calendar.dateInterval(of: component, for: self)?.start ?? self
        #endif
    }

    /// Returns a new `Date` representing the date calculated
    /// by adjusting to the end of a given component of a date.
    public func endOf(
        _ component: Calendar.Component,
        in calendar: Calendar = .current
    ) -> Date {
        // Incompatible components: `calendar`, `timeZone`, `isLeapMonth`
        #if DEBUG
        let date = calendar.dateInterval(of: component, for: self)!.end
        #else
        let date = calendar.dateInterval(of: component, for: self)?.end ?? self
        #endif

        return Date(timeInterval: -0.001, since: date)
    }
}

// MARK: - Comparison

extension Date {
    /// Compares whether the date is before, after or equal to the given `date`
    /// based on the granularity of their components.
    public func compare(
        to date: Date,
        granularity: Calendar.Component,
        in calendar: Calendar = .current
    ) -> ComparisonResult {
        calendar.compare(self, to: date, toGranularity: granularity)
    }

    /// Returns `true` if the date is equal to the given `date`
    /// based on the granularity of their components.
    public func isSame(
        _ date: Date,
        granularity: Calendar.Component,
        in calendar: Calendar = .current
    ) -> Bool {
        compare(to: date, granularity: granularity, in: calendar) == .orderedSame
    }

    /// Returns `true` if the date is before the given `date`
    /// based on the granularity of their components.
    public func isBefore(
        _ date: Date,
        orEqual: Bool = false,
        granularity: Calendar.Component,
        in calendar: Calendar = .current
    ) -> Bool {
        let result = compare(to: date, granularity: granularity, in: calendar)
        return orEqual
            ? (result == .orderedSame || result == .orderedAscending)
            : result == .orderedAscending
    }

    /// Returns `true` if the date is after the given `date`
    /// based on the granularity of their components.
    public func isAfter(
        _ date: Date,
        orEqual: Bool = false,
        granularity: Calendar.Component,
        in calendar: Calendar = .current
    ) -> Bool {
        let result = compare(to: date, granularity: granularity, in: calendar)
        return orEqual
            ? (result == .orderedSame || result == .orderedDescending)
            : result == .orderedDescending
    }
}

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
    public func components(
        _ components: Set<Calendar.Component>,
        in calendar: Calendar = .current
    ) -> DateComponents {
        calendar.dateComponents(components, from: self)
    }
}

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
