//
//  Defaults+Published.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 06.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Combine
import Defaults

@propertyWrapper
public class DefaultPublished<Value>: ObservableObject where Value: Codable & Equatable {
    private var cancellables = Set<AnyCancellable>()

    public init(_ key: Defaults.Keys.Key<Value>) {
        wrappedValue = Defaults[key]
        Publishers.CombineLatest(projectedValue, Defaults.publisher(key).map(\.newValue))
            .sink { [weak self] value in
                let newValue = self?.wrappedValue == value.0 ? value.1 : value.0
                self?.wrappedValue = newValue
                Defaults[key] = newValue
            }
            .store(in: &cancellables)
    }

    @Published
    public var wrappedValue: Value {
        willSet {
            objectWillChange.send()
        }
    }

    public lazy var projectedValue = $wrappedValue
}
