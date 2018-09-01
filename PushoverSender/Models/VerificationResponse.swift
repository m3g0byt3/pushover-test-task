//
//  VerificationResponse.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

struct VerificationResponse: Codable {

    // MARK: - Typealiases

    typealias Request = String
    typealias Device = String

    // MARK: - Public properties

    let status: Int
    let request: Request
    let group: Int
    let devices: [Device]?
}