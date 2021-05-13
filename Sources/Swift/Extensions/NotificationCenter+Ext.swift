//
//  NotificationCenter+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 02.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Combine

extension NotificationCenter.Event {
    public var orientationDidChangePublisher: AnyPublisher<Notification, Never> {
        NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .receiveOnMain()
            .eraseToAnyPublisher()
    }
}
