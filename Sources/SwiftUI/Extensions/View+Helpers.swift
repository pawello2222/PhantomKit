//
//  View+Helpers.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 29/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct InvisibleShape: View {
    public var body: some View {
        Color.black
            .opacity(.minimumOpacity)
    }
}

public struct IndicatorView: View {
    public var body: some View {
        Image(system: .chevronRight)
            .imageScale(.small)
            .font(Font.body.weight(.semibold))
            .foregroundUIColor(.darkGray)
    }
}
