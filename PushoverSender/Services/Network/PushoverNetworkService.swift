//
//  PushoverNetworkService.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Moya
import Result

/// Adapter for `PushoverAPI` Moya target.
final class PushoverNetworkService: NetworkService {

    // MARK: - Private properties

    /// Moya provider.
    private let provider: MoyaProvider<PushoverAPI>

    // MARK: - Initialization

    /// Init with given Moya provider.
    /// - Parameter provider: Moya provider.
    /// - Returns: New `PushoverNetworkService` instance.
    init(provider: MoyaProvider<PushoverAPI>) {
        self.provider = provider
    }

    // MARK: - NetworkService protocol conformance

    func send(message: Message, completion: @escaping NetworkService.Completion) {
        let moyaCompletion = completionFactory(completion: completion)
        provider.request(.send(message), completion: moyaCompletion)
    }

    func verify(recipient: Recipient, completion: @escaping NetworkService.Completion) {
        let moyaCompletion = completionFactory(completion: completion)
        provider.request(.verify(recipient), completion: moyaCompletion)
    }

    // MARK: - Private API

    /// Create completion closure for Moya provider.
    /// - Parameter completion: completion passed to the adapter.
    /// - Returns: New Moya provider completion closure.
    private func completionFactory<T: Codable>(
        completion: @escaping (Result<T, AnyError>) -> Void
    ) -> Moya.Completion {
        return { result in
            switch result {
            case .success(let response):
                do {
                    // Filtering in 200...499 range because we want to map 4xx responses as well
                    let filteredResponse = try response.filter(statusCodes: 200...499)
                    let mappedResponse = try filteredResponse.map(T.self)
                    DispatchQueue.main.async { completion(.success(mappedResponse)) }
                } catch {
                    // Catch Moya errors (mapping, etc)
                    let wrappedError = AnyError(error)
                    DispatchQueue.main.async { completion(.failure(wrappedError)) }
                }
            case .failure(let error):
                // Catch underlying errors (network reachability, etc)
                let wrappedError = AnyError(error)
                DispatchQueue.main.async { completion(.failure(wrappedError)) }
            }
        }
    }
}
