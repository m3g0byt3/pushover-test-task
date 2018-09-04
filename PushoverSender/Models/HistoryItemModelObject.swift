//
//  HistoryItemModelObject.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RealmSwift

/// Persistence representation of sent message.
@objcMembers final class HistoryItemModelObject: Object {

    // MARK: - Public properties

    /// Message sent date.
    dynamic var date = Date()

    /// Message delivery status.
    dynamic var isSuccessful = true

    /// Message title.
    dynamic var title = ""

    /// Message text.
    dynamic var text = ""

    /// The recipient of message.
    dynamic var recipientKey = ""

    // MARK: - Initialization

    /// Convenience initializer from immutable message representation.
    /// - Parameter model: Immutable message representation
    /// - Returns: new `HistoryItemModelObject` instance.
    convenience required init(model: HistoryItem) {
        self.init()
        self.date = model.date
        self.isSuccessful = model.isSuccessful
        self.title = model.message.title
        self.text = model.message.text
        self.recipientKey = model.message.recipient.key
    }
}

// MARK: - ModelObject protocol conformance

extension HistoryItemModelObject: ModelObject {

    var model: HistoryItem {
        let recipient = Recipient(key: recipientKey, device: nil)
        let message = Message(recipient: recipient, title: title, text: text)

        return HistoryItem(message: message, isSuccessful: isSuccessful, date: date)
    }
}
