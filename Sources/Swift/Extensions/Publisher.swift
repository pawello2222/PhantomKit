//
//  Publisher.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 06.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Combine

extension Publisher {
    public func receiveOnMain(
        options: DispatchQueue.SchedulerOptions? = nil
    ) -> Publishers.ReceiveOn<Self, DispatchQueue> {
        receive(on: .main, options: options)
    }
}

// MARK: -  Combine Latest

extension Publishers.CombineLatest where A.Output: Equatable, B.Output: Equatable {
    public func removeAllDuplicates() -> AnyPublisher<Output, Failure> {
        Publishers.CombineLatest(
            a.removeDuplicates(),
            b.removeDuplicates()
        )
        .eraseToAnyPublisher()
    }
}

extension Publishers.CombineLatest3 where A.Output: Equatable, B.Output: Equatable, C.Output: Equatable {
    public func removeAllDuplicates() -> AnyPublisher<Output, Failure> {
        Publishers.CombineLatest3(
            a.removeDuplicates(),
            b.removeDuplicates(),
            c.removeDuplicates()
        )
        .eraseToAnyPublisher()
    }
}

extension Publishers.CombineLatest4 where A.Output: Equatable, B.Output: Equatable, C.Output: Equatable, D.Output: Equatable {
    public func removeAllDuplicates() -> AnyPublisher<Output, Failure> {
        Publishers.CombineLatest4(
            a.removeDuplicates(),
            b.removeDuplicates(),
            c.removeDuplicates(),
            d.removeDuplicates()
        )
        .eraseToAnyPublisher()
    }
}
