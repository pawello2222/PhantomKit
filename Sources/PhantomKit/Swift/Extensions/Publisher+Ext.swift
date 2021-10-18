//
//  Publisher+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 06.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Combine
import Foundation

// MARK: - Combine Latest

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

// MARK: - Ensure Time Span

extension Publisher {
    public func ensureTimeSpan(_ interval: TimeInterval) -> AnyPublisher<Output, Failure> {
        let timer = Just<Void>(())
            .delay(for: .seconds(interval), scheduler: DispatchQueue.main)
            .setFailureType(to: Failure.self)
        return zip(timer)
            .map(\.0)
            .eraseToAnyPublisher()
    }
}

// MARK: - Receive

extension Publisher {
    public func receiveOnMain(
        options: DispatchQueue.SchedulerOptions? = nil
    ) -> Publishers.ReceiveOn<Self, DispatchQueue> {
        receive(on: .main, options: options)
    }
}

// MARK: - Async/await Support

// Adopted from here: https://www.swiftbysundell.com/articles/connecting-async-await-with-other-swift-code/
extension Publisher {
    public func singleResult() async throws -> Output {
        var cancellable: AnyCancellable?
        var didReceiveValue = false

        return try await withCheckedThrowingContinuation { continuation in
            cancellable = sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    case .finished:
                        if !didReceiveValue {
                            continuation.resume(throwing: Publishers.MissingOutputError())
                        }
                    }
                },
                receiveValue: { value in
                    guard !didReceiveValue else { return }
                    didReceiveValue = true
                    cancellable?.cancel()
                    continuation.resume(returning: value)
                }
            )
        }
    }
}

extension Publishers {
    public struct MissingOutputError: Error {}
}
