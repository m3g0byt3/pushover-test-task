//
//  ErrorResponse.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {

    // MARK: - Constants

    private static let unknown = "Unknown Pushover API error."

    // MARK: - Typealiases

    typealias Request = String

    // MARK: - Public properties

    let status: Int
    let request: Request
    let errors: [String]
    var apiError: PushoverError {
        return PushoverError(errorDescription: errors.first)
    }
}
