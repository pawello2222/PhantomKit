//
//  ByteCountFormatter+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension ByteCountFormatter {
    public func string(for data: Data) -> String {
        string(fromByteCount: Int64(data.count))
    }
}
