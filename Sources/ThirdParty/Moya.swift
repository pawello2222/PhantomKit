//
//  Moya.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 07.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

#if canImport(Moya) && canImport(CombineMoya)

import Combine
import CombineMoya
import Moya

// MARK: - MoyaProvider

extension MoyaProvider where Target: APIErrorMappable {
    func requestAndParsePublisher<Result>(
        _ target: Target,
        for resultType: Result.Type
    ) -> AnyPublisher<Result, APIError> where Result: Decodable {
        requestPublisher(target)
            .parseNetworkError()
            .map(\.data)
            .flatMap(decode)
            .eraseToAnyPublisher()
    }

    func decode<Result>(_ data: Data) -> AnyPublisher<Result, APIError> where Result: Decodable {
        Just(data)
            .decode(type: Result.self, decoder: JSONDecoder())
            .tryCatch { _ in
                Just(data)
                    .decode(type: Target.ErrorResponse.self, decoder: JSONDecoder())
                    .mapError {
                        APIError.parsing(message: $0.localizedDescription)
                    }
                    .tryMap { errorResponse in
                        throw Target.parseError(from: errorResponse)
                    }
                    .eraseToAnyPublisher()
            }
            .mapError { $0 as? APIError ?? APIError() }
            .eraseToAnyPublisher()
    }
}

// MARK: - Publisher

extension Publisher where Output == Moya.Response, Failure == MoyaError {
    func parseNetworkError() -> AnyPublisher<Moya.Response, APIError> {
        mapError { error in
            if error.errorCode == -1009 {
                return .offline
            }
            return .network(code: error.errorCode, message: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
}

#endif
