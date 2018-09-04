//
//  ScanService.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 02/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// QR code recognition adapter.
protocol ScanService {

    /// Delegate, conforms to the `ScanServiceDelegate` protocol.
    var delegate: ScanServiceDelegate? { get set }

    /// Prepare QR code recognition.
    func prepare()

    /// Start QR code recognition.
    func start()

    /// Stop QR code recognition.
    func stop()
}
