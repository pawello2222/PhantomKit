//
//  LocalizedDateFormatter.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 09.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension LocalizedFormatter {
    public static func makeDateFormatter(
        locale: Locale = .current,
        format: String = "yyyyMMdd"
    ) -> DateFormatter {
        .init().apply {
            $0.locale = locale
            $0.setLocalizedDateFormatFromTemplate(format)
        }
    }
}

extension LocalizedFormatter {
    public static func makeDateComponentsFormatter(
        locale: Locale = .current,
        allowedUnits: NSCalendar.Unit = [.hour, .minute, .second],
        unitsStyle: DateComponentsFormatter.UnitsStyle = .full
    ) -> DateComponentsFormatter {
        .init().apply {
            $0.calendar = .current.applying {
                $0.locale = locale
            }
            $0.allowedUnits = allowedUnits
            $0.unitsStyle = unitsStyle
        }
    }
}

// MARK: - Convenience

extension LocalizedFormatter {
    public static var date = makeDateFormatter()

    public static var datetime = makeDateFormatter(format: "yyyyMMddHHmmss")

    public static var dateComponents = makeDateComponentsFormatter()
}
