//
//  SortOption.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Represents sorting by keypath
enum SortOption {

    case ascending(keyPath: String)
    case descending(keyPath: String)

    // MARK: - Properties

    var ascending: Bool {
        if case .ascending = self { return true }
        return false
    }

    var keyPath: String {
        switch self {
        case .ascending(let keyPath), .descending(let keyPath): return keyPath
        }
    }
}
