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

    enum Interface {
        static let alertCloseButtonTitle = "OK"
        static let sentTitle = "Sent"
        static let scheduledTitle = "Scheduled"
        static let borderWidth: CGFloat = 1.0
        static let cornerRadius: CGFloat = 5.0
        static let borderColor = UIColor(displayP3Red: 233.0 / 255.0,
                                         green: 233.0 / 255.0,
                                         blue: 233.0 / 255.0,
                                         alpha: 1.0)
    }

    enum Identifier {
        static let sentCell = "Sent Cell"
        static let scheduledCell = "Scheduled Cell"
    }
}
