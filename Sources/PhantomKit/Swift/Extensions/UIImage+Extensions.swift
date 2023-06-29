//
//  UIImage+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import UIKit

extension UIImage {
    public enum JPEGQuality: CGFloat, CaseIterable {
        case lowest = 0.1
        case low = 0.5
        case medium = 0.6
        case high = 0.65
        case highest = 0.8
    }
}

extension UIImage {
    public func jpegData(quality: JPEGQuality = .highest) -> Data? {
        jpegData(compressionQuality: quality.rawValue)
    }
}
