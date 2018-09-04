//
//  HistoryItem.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Represents sent message.
struct HistoryItem {

    // MARK: - Public properties

    /// Message itself.
    let message: Message

    /// Message delivery status.
    let isSuccessful: Bool

    /// Message sent date.
    let date: Date
}

// MARK: - Convenience Initializers

extension HistoryItem {

    /// Convenience initializer from message and an API response.
    /// - Parameters:
    ///     - message: Sent message.
    ///     - response: An API response.
    /// - Returns: New `HistoryItem` instance.
    init(message: Message, response: APIResponse) {
        self.message = message
        self.isSuccessful = response.isSuccessful
        self.date = Date()
    }

    /// Convenience initializer from message and an error.
    /// - Parameters:
    ///     - message: Sent message.
    ///     - error: An error.
    /// - Returns: New `HistoryItem` instance.
    init(message: Message, error: Error) {
        self.message = message
        self.isSuccessful = false
        self.date = Date()
    }
}

// MARK: - Model protocol conformance

extension HistoryItem: Model {

    var modelObject: HistoryItemModelObject {
        return HistoryItemModelObject(model: self)
    }
}
