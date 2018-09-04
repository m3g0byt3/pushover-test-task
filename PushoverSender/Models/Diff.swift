//
//  Diff.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Represents changes in collection.
enum Diff {

    /// Initial state.
    case initial

    /// Collection is updated.
    case updates(deletions: [IndexPath], insertions: [IndexPath], modifications: [IndexPath])
}
