//
// Copyright (c) 2024-Present Paweł Wiszenko. All rights reserved.
//

import Foundation

extension Error {
    public var nsError: NSError {
        self as NSError
    }
}
