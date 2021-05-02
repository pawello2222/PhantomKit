//
//  NotificationCenter+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 02/05/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension NotificationCenter.Event {
    @discardableResult
    public func orientationDidChange(_ callback: @escaping () -> Void) -> NSObjectProtocol {
        observe(UIDevice.orientationDidChangeNotification, callback)
    }
}
