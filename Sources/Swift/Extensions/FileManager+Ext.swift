//
//  FileManager+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 24.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension FileManager {
    public var userDocumentDirectory: URL {
        urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
