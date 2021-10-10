//
//  WebView+ViewModel.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25.04.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension WebView {
    public class ViewModel: ObservableObject {
        let endpoint: WebEndpoint
        let onDismiss: (() -> Void)?

        @Published public var didFinishLoading = false

        public init(_ endpoint: WebEndpoint, onDismiss: (() -> Void)? = nil) {
            self.endpoint = endpoint
            self.onDismiss = onDismiss
        }
    }
}
