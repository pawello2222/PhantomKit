//
//  PopupView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 30.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct PopupView: View {
    private let message: Message

    public init(message: Message) {
        self.message = message
    }

    public var body: some View {
        VStack(spacing: .defaultPadding) {
            Text(message.title)
                .font(Font.body.weight(.bold))
                .fixedSize(.vertical)
                .lineLimit(message.title.count > 30 ? nil : 1)
            Text(message.text)
                .font(Font.callout.weight(.medium))
                .fixedSize(.vertical)
        }
        .allowsTightening(true)
        .multilineTextAlignment(.center)
        .foregroundColor(Color.black)
        .padding(.maximumPadding)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
        )
        .padding(.maximumPadding)
        .expandingBackgroundColor(Color.black.opacity(0.75))
        .transition(.opacity)
    }
}
