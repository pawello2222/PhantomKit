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

// MARK: - SKProductSubscriptionPeriod

extension SKProductSubscriptionPeriod {
    var durationTitle: String {
        switch unit {
        case .day:
            return "day"
        case .week:
            return "week"
        case .month:
            return "month"
        case .year:
            return "year"
        default:
            return "unknown"
        }
    }
}
