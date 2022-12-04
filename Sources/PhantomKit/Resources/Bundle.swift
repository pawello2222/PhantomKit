//
//  Bundle.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Bundle {
    public static var phantomKit: Bundle {
        .init(for: Self.self)
    }
}
