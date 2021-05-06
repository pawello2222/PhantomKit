//
//  Defaults+Published.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 06.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

#if canImport(Defaults)
import Combine
import Defaults

extension Published where Value: Codable & Equatable {
    public init(_ key: Defaults.Keys.Key<Value>) {
        self.init(initialValue: Defaults[key])
        projectedValue
            .removeDuplicates()
            .sink { Defaults[key] = $0 }
            .store(in: &cancellables)
    }
}

extension Published where Value: Codable & Equatable {
    public init(wrappedValue defaultValue: Value, _ key: String, storage: UserDefaults = .standard) {
        self.init(Defaults.Keys.Key<Value>(key, default: defaultValue, suite: storage))
    }
}

// MARK: - Private

private var cancellables = Set<AnyCancellable>()
#endif
