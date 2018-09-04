//
//  ScanServiceDelegate.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 02/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import QuartzCore

/// Handle events from `ScanService` QR scanner.
protocol ScanServiceDelegate: AnyObject {

    /// Called when scanner unable to setup itself due to error.
    /// - Parameters:
    ///     - scanner: `ScanService` instance.
    ///     - error: An error.
    func scanner(_ scanner: ScanService, didFailWith error: ScannerError)

    /// Called when scanner successfully setup preview layer.
    /// - Parameters:
    ///     - scanner: `ScanService` instance.
    ///     - layer: A preview layer.
    func scanner(_ scanner: ScanService, didSetupPreview layer: CALayer)

    /// Called when scanner successfully recognized QR code.
    /// - Parameters:
    ///     - scanner: `ScanService` instance.
    ///     - layer: QR code string value.
    func scanner(_ scanner: ScanService, didRecognizedCode value: String)
}
