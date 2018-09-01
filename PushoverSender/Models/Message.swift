//
//  Message.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

struct Message {

    // MARK: - Public properties

    let recipient: Recipient
    let title: String
    let message: String
}
