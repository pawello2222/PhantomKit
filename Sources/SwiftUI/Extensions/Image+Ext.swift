//
//  Image+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 23.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension Data {
    public func asImage() -> Image? {
        guard let uiImage = UIImage(data: self) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
}
