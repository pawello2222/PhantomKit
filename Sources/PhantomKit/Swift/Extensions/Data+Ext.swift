//
//  Data+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 24.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension Data {
    public func writeToDocumentDirectory(filename: String, fileExt: String) throws -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let outputFileURL = documentDirectory
            .appendingPathComponent(filename)
            .appendingPathExtension(fileExt)
        try write(to: outputFileURL)
        return outputFileURL
    }
}
