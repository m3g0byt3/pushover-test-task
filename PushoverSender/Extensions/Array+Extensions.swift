//
//  Array+Extensions.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

extension Array {

    subscript(safe index: Index) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }

    subscript(safeAfter index: Index) -> Element? {
        return self[safe: index + 1]
    }

    subscript(safeBefore index: Index) -> Element? {
        return self[safe: index - 1]
    }
}
