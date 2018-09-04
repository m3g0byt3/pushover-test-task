//
//  Response.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Represents response to an API request.
struct APIResponse: Codable {

    // MARK: - Constants

    /// Description message for unknown API errors.
    private static let unknown = "Unknown Pushover API error."

    /// API status raw value for successful requests.
    private static let successful = 1

    // MARK: - Typealiases

    typealias Request = String
    typealias Receipt = String
    typealias Device = String

    // MARK: - Public properties

    /// API request status.
    private let status: Int

    /// Randomly-generated unique token that have been associated with an API request.
    let request: Request

    /// Optional unique token that have been associated with an
    /// API request when sending message with Emergency Priority.
    let receipt: Receipt?

    /// Optional array of error messages.
    let errors: [String]?

    /// Optional group ID of recipient.
    let group: Int?

    /// Optional array of recipient's devices.
    let devices: [Device]?

    /// API request status.
    var isSuccessful: Bool {
        return status == APIResponse.successful
    }

    /// Description message for an API response.
    var message: String {
        switch status {
        case APIResponse.successful: return "Message sent successfully with token: \"\(request)\"."
        default: return "Unable to send message with token \"\(request)\" due to error:\n"
            + "\(errors?.first ?? APIResponse.unknown)"
        }
    }

    /// Description title for an API response.
    var title: String {
        switch status {
        case APIResponse.successful: return "Done"
        default: return "Error"
        }
    }
}
