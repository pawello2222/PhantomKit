//
//  Section+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension Section where Parent == Text, Content: View, Footer: View {
    /// Creates a section with the provided section content.
    /// - Parameters:
    ///   - titleKey: The key for the section's localized title, which describes
    ///     the contents of the section.
    ///   - content: The section's content.
    ///   - footer: A view to use as the section's footer.
    public init(
        _ titleKey: LocalizedStringKey,
        @ViewBuilder content: () -> Content,
        @ViewBuilder footer: () -> Footer
    ) {
        self.init(content: content, header: { Text(titleKey) }, footer: footer)
    }

    /// Creates a section with the provided section content.
    /// - Parameters:
    ///   - title: A string that describes the contents of the section.
    ///   - content: The section's content.
    ///   - footer: A view to use as the section's footer.
    public init<S>(
        _ title: S,
        @ViewBuilder content: () -> Content,
        @ViewBuilder footer: () -> Footer
    ) where S: StringProtocol {
        self.init(content: content, header: { Text(title) }, footer: footer)
    }
}
