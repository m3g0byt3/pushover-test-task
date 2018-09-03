//
//  HistoryItem.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

struct HistoryItem {

    // MARK: - Constants

    private static let successful = 1

    // MARK: - Public properties

    let message: Message
    let isSuccessful: Bool
    let date: Date

    // MARK: - Initialization

    init(message: Message, response: APIResponse) {
        self.message = message
        self.isSuccessful = response.isSuccessful
        self.date = Date()
    }

    init(message: Message, error: Error) {
        self.message = message
        self.isSuccessful = false
        self.date = Date()
    }
}

extension HistoryItem: Model {

    var modelObject: HistoryItemModelObject {
        return HistoryItemModelObject(model: self)
    }
}
