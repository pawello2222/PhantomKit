//
//  StoreKit+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import StoreKit

// MARK: - SKStoreReviewController

extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.firstWindowScene {
            requestReview(in: scene)
        }
    }
}

// MARK: - SKProduct.PeriodUnit

extension SKProduct.PeriodUnit {
    public func toCalendarUnit() -> NSCalendar.Unit {
        switch self {
        case .day:
            return .day
        case .month:
            return .month
        case .week:
            return .weekOfMonth
        case .year:
            return .year
        @unknown default:
            return .day
        }
    }
}
