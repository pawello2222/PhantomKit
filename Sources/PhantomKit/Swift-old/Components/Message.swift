////
////  Message.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 28.05.2021.
////  Copyright © 2021 Pawel Wiszenko. All rights reserved.
////
//
//import Foundation
//
//public struct Message: Hashable, Equatable {
//    public let title: String
//    public let text: String
//
//    public init(title: String, text: String) {
//        self.title = title
//        self.text = text
//    }
//}
//
//// MARK: - ExpressibleByStringLiteral
//
//extension Message: ExpressibleByStringLiteral {
//    public init(stringLiteral value: String) {
//        self.init(value)
//    }
//}
//
//// MARK: - Convenience
//
//extension Message {
//    public init(_ text: String) {
//        title = ""
//        self.text = text
//    }
//
//    public init?(_ text: String?) {
//        guard let text = text else {
//            return nil
//        }
//        self.init(text)
//    }
//}
