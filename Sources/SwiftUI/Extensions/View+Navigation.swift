//
//  View+Navigation.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 24/04/2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

extension View {
    public func embedInNavigation(_ title: String) -> some View {
        navigationTitle(title)
            .embedInNavigation()
    }
}

extension View {
    public func embedInStackNavigation() -> some View {
        embedInNavigation()
            .navigationViewStyle(StackNavigationViewStyle())
    }
}
