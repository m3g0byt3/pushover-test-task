//
//  Recipient.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Represents recipient of message.
struct Recipient {

    // MARK: - Typealiases

    typealias Key = String
    typealias Device = String

    // MARK: - Public properties

    /// Address (API key) of recipient.
    let key: Key

    /// Unique device of recipient.
    let device: Device?
}
