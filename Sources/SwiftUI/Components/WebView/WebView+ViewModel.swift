//
//  WebView+ViewModel.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 25/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension WebView {
    public class ViewModel: ObservableObject {
        let title: String
        @Published var url: String
        @Published var isNavigationAllowed: Bool
        let dismissAction: (() -> Void)?

        @Published public var didFinishLoading = false

        public init(
            title: String,
            url: String,
            isNavigationAllowed: Bool = true,
            dismissAction: (() -> Void)? = nil
        ) {
            self.title = title
            self.url = url
            self.isNavigationAllowed = isNavigationAllowed
            self.dismissAction = dismissAction
        }
    }
}
