//
//  Message.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Represents message.
struct Message {

    // MARK: - Public properties

    /// The recipient of message.
    let recipient: Recipient

    /// Message title.
    let title: String

    /// Message text.
    let text: String
}
