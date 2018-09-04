//
//  Array+Extensions.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

extension Array {

    /// Returns element with given index or `nil` if an index is out of bounds.
    /// - Parameter index: Given index.
    /// - Returns: `Element` instance.
    subscript(safe index: Index) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }

    /// Returns element with given index + 1 or `nil` if an index is out of bounds.
    /// - Parameter index: Given index.
    /// - Returns: `Element` instance.
    subscript(safeAfter index: Index) -> Element? {
        return self[safe: index + 1]
    }

    /// Returns element with given index - 1 or `nil` if an index is out of bounds.
    /// - Parameter index: Given index.
    /// - Returns: `Element` instance.
    subscript(safeBefore index: Index) -> Element? {
        return self[safe: index - 1]
    }
}
