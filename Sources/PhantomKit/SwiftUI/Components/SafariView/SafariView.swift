//
//  SafariView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 09.06.2021.
//  Copyright © 2021 Tersacore. All rights reserved.
//

import SafariServices
import SwiftUI

public struct SafariView: View {
    private let url: URL

    public init(url: URL) {
        self.url = url
    }

    public var body: some View {
        SafariViewRepresentable(url: url)
            .ignoresSafeArea()
    }
}

// MARK: - Representable

public struct SafariViewRepresentable: UIViewControllerRepresentable {
    private let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
