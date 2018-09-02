//
//  ScanServiceDelegate.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 02/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import QuartzCore

protocol ScanServiceDelegate: AnyObject {

    func scanner(_ scanner: ScanService, didFailWith error: ScannerError)

    func scanner(_ scanner: ScanService, didSetupPreview layer: CALayer)

    func scanner(_ scanner: ScanService, didRecognizedCode value: String)
}
