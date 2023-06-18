////
////  Logger.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 07.05.2021.
////  Copyright © 2021 Pawel Wiszenko. All rights reserved.
////
//
//import Foundation
//import os.log
//
//public enum Logger {
//    public typealias Category = OSLog
//
//    public static func log(_ message: String, category: Category, type: OSLogType) {
//        #if DEBUG
//        os_log("%@", log: category, type: type, message)
//        #endif
//    }
//
//    public static func debug(_ message: String, category: Category) {
//        log(message, category: category, type: .debug)
//    }
//
//    public static func info(_ message: String, category: Category) {
//        log(message, category: category, type: .info)
//    }
//
//    public static func error(_ message: String, category: Category) {
//        log(message, category: category, type: .error)
//    }
//
//    public static func fault(_ message: String, category: Category) {
//        log(message, category: category, type: .fault)
//    }
//}
//
//// MARK: - Categories
//
//extension Logger.Category {
//    private static let subsystem = Bundle.phantomKit.identifier
//
//    public static let network = Logger.Category(subsystem: subsystem, category: "Network")
//}
