//
//  PDFViewRepresentable.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 05/07/2023.
//  Copyright © 2023 Tersacore. All rights reserved.
//

import PDFKit
import SwiftUI

public struct PDFViewRepresentable: UIViewRepresentable {
    private let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func makeUIView(context: Context) -> PDFView {
        .init().apply {
            $0.document = .init(url: url)
            $0.autoScales = true
        }
    }

    public func updateUIView(_ uiView: PDFView, context: Context) {}
}
