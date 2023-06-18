////
////  UserDefaults+Ext.swift
////  PhantomKit
////
////  Created by Pawel Wiszenko on 25.05.2021.
////  Copyright © 2021 Pawel Wiszenko. All rights reserved.
////
//
//import SwiftUI
//
//// MARK: - UIColor
//
//extension UserDefaults {
//    public func color(forKey key: String) -> UIColor? {
//        guard let colorData = data(forKey: key) else {
//            return nil
//        }
//        return try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)
//    }
//
//    public func set(_ value: UIColor?, forKey key: String) {
//        if let color = value {
//            let colorData = try? NSKeyedArchiver.archivedData(
//                withRootObject: color,
//                requiringSecureCoding: false
//            )
//            set(colorData, forKey: key)
//        }
//    }
//}
//
//// MARK: - Color
//
//extension UserDefaults {
//    public func color(forKey key: String) -> Color? {
//        guard let uiColor: UIColor = color(forKey: key) else {
//            return nil
//        }
//        return Color(uiColor)
//    }
//
//    public func set(_ value: Color, forKey key: String) {
//        set(UIColor(value), forKey: key)
//    }
//}
