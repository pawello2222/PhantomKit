//
//  RequestState.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 11.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

enum RequestState: Equatable {
    case notStarted
    case inProgress
    case succeeded
    case failed

    var isFinished: Bool {
        isContained(in: [.succeeded, .failed])
    }
}
