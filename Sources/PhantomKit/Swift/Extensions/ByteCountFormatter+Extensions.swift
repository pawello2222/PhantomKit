//
//  ByteCountFormatter+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import Foundation

extension ByteCountFormatter {
    public func string(for data: Data) -> String {
        string(fromByteCount: Int64(data.count))
    }
}
