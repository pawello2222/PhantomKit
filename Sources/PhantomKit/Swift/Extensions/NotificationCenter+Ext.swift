////
////  NotificationCenter+Ext.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 02.05.2021.
////  Copyright © 2021 Pawel Wiszenko. All rights reserved.
////
//
//import Combine
//import UIKit
//
//extension NotificationCenter.Event {
//    public func notificationPublisher(for name: Notification.Name) -> AnyPublisher<Notification, Never> {
//        NotificationCenter.default.publisher(for: name)
//            .receiveOnMain()
//            .eraseToAnyPublisher()
//    }
//}
//
//// MARK: - UIDevice
//
//extension NotificationCenter.Event {
//    public var orientationDidChangePublisher: AnyPublisher<Notification, Never> {
//        notificationPublisher(for: UIDevice.orientationDidChangeNotification)
//    }
//}
