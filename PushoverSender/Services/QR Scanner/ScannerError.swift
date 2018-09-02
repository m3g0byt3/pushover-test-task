//
//  ScannerError.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 02/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

enum ScannerError: Error, LocalizedError {

    case noAccess
    case unableToGetDevice
    case unknown
}
