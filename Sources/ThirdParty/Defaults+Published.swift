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

extension Published {
    public init(_ key: Defaults.Keys.Key<Value>) where Value: Codable {
        self.init(initialValue: Defaults[key])
        projectedValue
            .sink { value in
                Defaults[key] = value
            }
            .store(in: &cancellables)
    }
}

// MARK: - Private

private var cancellables = Set<AnyCancellable>()
#endif
