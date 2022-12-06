//
//  FileManager+Extensions.swift
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

extension FileManager {
    public func loadData(
        filename: String,
        extension ext: String = "json",
        in bundle: Bundle = .main
    ) throws -> Data {
        guard let url = bundle.url(forResource: filename.deletingPathExtension, withExtension: ext) else {
            throw CocoaError(.fileNoSuchFile)
        }
        return try Data(contentsOf: url)
    }

    public func load<Result>(
        filename: String,
        extension ext: String = "json",
        in bundle: Bundle = .main,
        decoding type: Result.Type
    ) throws -> Result where Result: Decodable {
        let data = try loadData(filename: filename, extension: ext, in: bundle)
        return try JSONDecoder().decode(Result.self, from: data)
    }
}
