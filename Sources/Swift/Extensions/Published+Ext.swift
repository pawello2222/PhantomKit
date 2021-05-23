//
//  Published+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 01.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Combine
import Foundation

extension Published {
    public init(wrappedValue defaultValue: Value, key: String, storage: UserDefaults = .standard) {
        let value = storage.object(forKey: key) as? Value ?? defaultValue
        self.init(initialValue: value)
        projectedValue
            .sink { value in
                storage.set(value, forKey: key)
            }
            .store(in: &cancellables)
    }
}

extension Published where Value: Codable {
    public init(wrappedValue defaultValue: Value, codableKey key: String, storage: UserDefaults = .standard) {
        if
            let data = storage.data(forKey: key),
            let decodedValue = try? JSONDecoder().decode(Value.self, from: data)
        {
            self.init(initialValue: decodedValue)
        } else {
            self.init(initialValue: defaultValue)
        }
        projectedValue
            .sink { value in
                if let data = try? JSONEncoder().encode(value) {
                    storage.set(data, forKey: key)
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Private

private var cancellables = Set<AnyCancellable>()
