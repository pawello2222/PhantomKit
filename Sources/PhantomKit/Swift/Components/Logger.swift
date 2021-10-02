//
//  Logger.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 07.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import os.log

public enum Logger {
    public static func log(_ message: String, category: OSLog, type: OSLogType) {
        os_log("%@", log: category, type: type, message)
    }

    public static func debug(_ message: String, category: OSLog) {
        log(message, category: category, type: .debug)
    }

    public static func info(_ message: String, category: OSLog) {
        log(message, category: category, type: .info)
    }

    public static func error(_ message: String, category: OSLog) {
        log(message, category: category, type: .error)
    }

    public static func fault(_ message: String, category: OSLog) {
        log(message, category: category, type: .fault)
    }
}
