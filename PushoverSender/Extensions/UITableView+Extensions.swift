//
//  UITableView+Extensions.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    /// Convenience method to apply changes from a `Diff` instance.
    /// - Parameters:
    ///     - diff: Given `Diff` instance.
    ///     - animation: Row animation (default value = `.automatic`)
    func apply(diff: Diff, with animation: UITableViewRowAnimation = .automatic) {
        switch diff {

        case .initial:
            reloadData()

        case let .updates(deletions, insertions, modifications):
            beginUpdates()
            insertRows(at: insertions, with: animation)
            deleteRows(at: deletions, with: animation)
            reloadRows(at: modifications, with: animation)
            endUpdates()
        }
    }
}
