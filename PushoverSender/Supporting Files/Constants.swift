//
//  Constants.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

enum Constants {

    // MARK: - Typealiases

    typealias ScanCompletion = (String) -> Void

    // MARK: - Constants

    enum Interface {
        static let errorTitle = "Error"
        static let errorMessage = "An error has occurred:\n"
        static let alertCloseButtonTitle = "OK"
        static let sentTitle = "Sent"
        static let scheduledTitle = "Scheduled"
        static let borderWidth: CGFloat = 1.0
        static let cornerRadius: CGFloat = 5.0
        static let borderColor = UIColor(displayP3Red: 233.0 / 255.0,
                                         green: 233.0 / 255.0,
                                         blue: 233.0 / 255.0,
                                         alpha: 1.0)
        static let placeholderColor = UIColor(displayP3Red: 205.0 / 255.0,
                                              green: 205.0 / 255.0,
                                              blue: 210.0 / 255.0,
                                              alpha: 1.0)
        static let xInset: CGFloat = 4.0
        static let yInsetDivider: CGFloat = 2.0
        static let animationDuration: TimeInterval = 0.3
        static let cancelButtonBottomRatio: CGFloat = 0.95
    }

    enum Identifier {
        static let sentCell = "Sent Cell"
        static let scheduledCell = "Scheduled Cell"
    }

    enum Network {
        static let apiToken = "af33c32b5wpe4aiusfx8eydu6e7ah5"
        static let baseURLHost = "api.pushover.net"
        static let baseURLScheme = "https"
        static let timeout: TimeInterval = 5.0
    }
}
