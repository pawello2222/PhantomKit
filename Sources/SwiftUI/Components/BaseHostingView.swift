//
//  BaseHostingView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 24/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

struct BaseHostingView<Content>: View where Content: View {
    let theme: Theme
    let content: Content

    var body: some View {
        content
            .environment(\.theme, theme)
    }
}
