////
////  RefreshGuardian.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 12.05.2021.
////  Copyright © 2021 Pawel Wiszenko. All rights reserved.
////
//
//import Foundation
//
//public enum RefreshGuardian {
//    public typealias Interval = (value: Int, granularity: Calendar.Component)
//
//    public class Key {
//        private let name: String
//        private let interval: Interval
//        private let suite: UserDefaults
//
//        public init(
//            name: String,
//            interval: Interval,
//            suite: UserDefaults = .standard
//        ) {
//            self.name = name
//            self.interval = interval
//            self.suite = suite
//        }
//    }
//}
//
//extension RefreshGuardian.Key {
//    public var lastUpdated: Date? {
//        get {
//            suite.object(forKey: key) as? Date
//        }
//        set {
//            suite.set(newValue, forKey: key)
//        }
//    }
//
//    public func canUpdate(for currentDate: Date = Date()) -> Bool {
//        guard let lastUpdated = lastUpdated else {
//            return true
//        }
//        let nextAllowedDate = lastUpdated.adjusting(interval.granularity, by: interval.value)
//        return nextAllowedDate.isBefore(currentDate, orEqual: true, granularity: interval.granularity)
//    }
//
//    private var key: String {
//        "refreshGuardian_\(name)_lastUpdated"
//    }
//}
