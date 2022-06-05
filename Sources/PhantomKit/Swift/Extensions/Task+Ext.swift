//
//  Task+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 05.06.2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    public static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
