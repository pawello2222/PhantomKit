//
// Copyright (c) 2024-Present Paweł Wiszenko. All rights reserved.
//

import SwiftUI

public struct IndicatorView: View {
    public init() {}

    public var body: some View {
        Image(systemName: "chevron.right")
            .imageScale(.small)
            .font(.body.weight(.medium))
            .foregroundColor(.secondary)
            .opacity(0.55)
    }
}
