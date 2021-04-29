//
//  View+Helpers.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 29/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct ClearShape: View {
    public var body: some View {
        Color.clear
            .contentShape(Rectangle())
    }
}
