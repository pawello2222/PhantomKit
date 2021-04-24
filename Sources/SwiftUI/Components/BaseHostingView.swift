//
//  BaseHostingView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 24/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

struct BaseHostingView<Content>: View where Content: View {
    @ObservedObject private var viewModel = ViewModel()
    let theme: Theme
    let content: Content

    var body: some View {
        content
//            .setDefaults(theme: Theme)
            .onPreferenceChange(DismissActionPreferenceKey.self) { action in
                viewModel.action = action
            }
    }

    func willDismiss(using method: DismissMethod) {
        viewModel.action?(method)
    }

    private final class ViewModel: ObservableObject {
        var action: DismissActionWrapper?
    }
}
