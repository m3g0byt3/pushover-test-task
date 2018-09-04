//
//  ScannerError.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 02/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

enum ScannerError: Error, LocalizedError {

    /// No access to camera provided.
    case noAccess

    /// Unable to setup camera device (e.g. hardware fault/simulator)
    case noDevice

    /// Unknown error.
    case unknown

    // MARK: - LocalizedError protocol conformance

    var errorDescription: String? {
        switch self {
        case .noAccess: return "Allow access to the camera for QR code scanning."
        case .noDevice: return "Unable to get camera device."
        case .unknown: return "An unknown error occurred."
        }
    }
}
