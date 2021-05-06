//
//  Publisher.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 06.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Combine

extension Publisher {
    public func receiveOnMain(
        options: DispatchQueue.SchedulerOptions? = nil
    ) -> Publishers.ReceiveOn<Self, DispatchQueue> {
        receive(on: .main, options: options)
    }
}
