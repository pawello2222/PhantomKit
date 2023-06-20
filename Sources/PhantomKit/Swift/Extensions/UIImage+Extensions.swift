//
//  UIImage+Extensions.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 21.05.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import UIKit

extension UIImage {
    public enum JPEGQuality: CGFloat {
        case lowest = 0
        case low = 0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1
    }
}

extension UIImage {
    public func jpegData(quality: JPEGQuality = .highest) -> Data? {
        jpegData(compressionQuality: quality.rawValue)
    }
}
