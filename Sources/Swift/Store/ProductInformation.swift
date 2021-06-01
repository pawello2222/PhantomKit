//
//  ProductInformation.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 01.06.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

public struct ProductInformation {
    public typealias Identifier = String
    public typealias SubscriptionPeriod = (value: Int, unit: Calendar.Component)

    public let identifier: Identifier
    public let period: SubscriptionPeriod?
}
