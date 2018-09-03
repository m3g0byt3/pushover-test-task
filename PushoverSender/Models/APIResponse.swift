//
//  Response.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

struct APIResponse: Codable {

    // MARK: - Constants

    private static let unknown = "Unknown Pushover API error."
    private static let successful = 1

    // MARK: - Typealiases

    typealias Request = String
    typealias Receipt = String
    typealias Device = String

    // MARK: - Public properties

    private let status: Int
    let request: Request
    let receipt: Receipt?
    let errors: [String]?
    let group: Int?
    let devices: [Device]?

    var isSuccessful: Bool {
        guard status == APIResponse.successful else { return false }
        return true
    }

    var message: String {
        switch status {
        case APIResponse.successful: return "Message sent successfully with token: \"\(request)\"."
        default: return "Unable to send message with token \"\(request)\" due to error:\n"
            + "\(errors?.first ?? APIResponse.unknown)"
        }
    }

    var title: String {
        switch status {
        case APIResponse.successful: return "Done"
        default: return "Error"
        }
    }
}
