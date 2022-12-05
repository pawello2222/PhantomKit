//
//  Route.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 04/12/2022.
//  Copyright © 2022 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

public protocol Route: Hashable, Identifiable {
    associatedtype Destination: View

    @ViewBuilder
    func view() -> Destination
}
