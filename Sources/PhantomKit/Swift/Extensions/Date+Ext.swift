//
//  Date+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Date {
    public func dateComponents(
        _ components: Set<Calendar.Component>,
        in calendar: Calendar = .default
    ) -> DateComponents {
        calendar.dateComponents(components, from: self)
    }
}

extension Date {
    public func localizedString(formatter: LocalizedDateFormatter = .date) -> String {
        formatter.string(from: self)
    }
}
