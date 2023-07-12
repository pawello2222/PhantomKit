//
//  File.swift
//
//
//  Created by Pawel Wiszenko on 12/07/2023.
//

import SafariServices
import SwiftUI

public struct SafariViewRepresentable: UIViewControllerRepresentable {
    private let url: URL
    private let tintColor: Color

    public init(url: URL, tintColor: Color = .accentColor) {
        self.url = url
        self.tintColor = tintColor
    }

    public func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url).apply {
            $0.preferredControlTintColor = .init(tintColor)
        }
    }

    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
