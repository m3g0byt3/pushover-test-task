//
//  Recipient.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

struct Recipient {

    // MARK: - Typealiases

    typealias Key = String
    typealias Device = String

    // MARK: - Public properties

    let key: Key
    let device: Device?
}
