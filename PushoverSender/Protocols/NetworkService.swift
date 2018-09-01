//
//  NetworkService.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import Result

typealias NetworkService = MessagingService & VerificationService

protocol MessagingService {

    // MARK: - Typealiases

    typealias Completion = (Result<MessageResponse, AnyError>) -> Void

    // MARK: - Protocol requirements

    func send(message: Message, completion: @escaping Completion)
}

protocol VerificationService {

    // MARK: - Typealiases

    typealias Completion = (Result<VerificationResponse, AnyError>) -> Void

    // MARK: - Protocol requirements

    func verify(recipient: Recipient, completion: @escaping Completion)
}
