//
//  LastUpdatedView.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 12.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public struct LastUpdatedView: View {
    private typealias L = Localized.LastUpdated

    private let date: Date?
    private let formatter: LocalizedDateFormatter

    public init(date: Date?, formatter: LocalizedDateFormatter = .datetime) {
        self.date = date
        self.formatter = formatter
    }

    public var body: some View {
        Text(L.lastUpdated(date?.localizedString(formatter: formatter) ?? L.never))
    }
}
