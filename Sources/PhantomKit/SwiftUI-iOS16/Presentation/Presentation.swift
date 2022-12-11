////
////  Presentation.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 25.04.2021.
////  Copyright © 2021 Pawel Wiszenko. All rights reserved.
////
//
//import SwiftUI
//
//public struct Presentation {
//    public let transition: Transition
//    public let trigger: Trigger
//
//    public init(transition: Transition = .default, trigger: Trigger = .default) {
//        self.transition = transition
//        self.trigger = trigger
//    }
//
//    public var isModal: Bool {
//        switch transition {
//        case .sheet, .fullScreen:
//            return true
//        case .link:
//            return false
//        }
//    }
//}
//
//// MARK: - Transition
//
//extension Presentation {
//    public enum Transition {
//        case link
//        case sheet
//        case fullScreen
//    }
//}
//
//// MARK: - Trigger
//
//extension Presentation {
//    public enum Trigger {
//        case tap
//        case button
//    }
//}
//
//// MARK: - Defaults
//
//extension Presentation.Transition {
//    public static var `default`: Self = .link
//}
//
//extension Presentation.Trigger {
//    public static var `default`: Self = .button
//}
//
//// MARK: - Convenience
//
//extension Presentation {
//    public static var link: Self {
//        .link(trigger: .default)
//    }
//
//    public static func link(trigger: Trigger) -> Self {
//        .init(transition: .link, trigger: trigger)
//    }
//
//    public static var sheet: Self {
//        .sheet(trigger: .default)
//    }
//
//    public static func sheet(trigger: Trigger) -> Self {
//        .init(transition: .sheet, trigger: trigger)
//    }
//
//    public static var fullScreen: Self {
//        .fullScreen(trigger: .default)
//    }
//
//    public static func fullScreen(trigger: Trigger) -> Self {
//        .init(transition: .fullScreen, trigger: trigger)
//    }
//}
