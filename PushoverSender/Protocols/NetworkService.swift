//
//  NetworkService.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Result

protocol NetworkService {

    // MARK: - Typealiases

    typealias Completion = (Result<APIResponse, AnyError>) -> Void

    // MARK: - Protocol requirements

    func send(message: Message, completion: @escaping Completion)

    func verify(recipient: Recipient, completion: @escaping Completion)
}
