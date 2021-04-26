//
//  SKStoreReviewController+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 26/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import StoreKit

extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.firstWindowScene {
            requestReview(in: scene)
        }
    }
}
