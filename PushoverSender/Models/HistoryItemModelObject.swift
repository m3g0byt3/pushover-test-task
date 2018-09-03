//
//  HistoryItemModelObject.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers final class HistoryItemModelObject: Object {

    // MARK: - Public properties

    dynamic var date = Date()
    dynamic var isSuccessful = true
    dynamic var title = ""
    dynamic var text = ""
    dynamic var recipientKey = ""

    // MARK: - Initialization

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
        fatalError("Not implemented yet")
    }
}
