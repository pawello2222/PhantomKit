//
//  ActionSheet+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension ActionSheet {
    public init(title: String, buttons: [ActionSheet.Button] = [.cancel()]) {
        self.init(title: Text(title), buttons: buttons)
    }

    public init(title: String, message: String, buttons: [ActionSheet.Button] = [.cancel()]) {
        self.init(title: Text(title), message: Text(message), buttons: buttons)
    }
}
