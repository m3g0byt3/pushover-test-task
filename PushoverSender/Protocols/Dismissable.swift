//
//  Dismissable.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 04/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

/// Allow add an array of `UIBarButtonItem` items to the `inputAccessoryView`.
protocol Dismissable: Customizable {

    var toolBarItems: [UIBarButtonItem] { get }
}

/// Provides dismiss button that will dismiss first responder.
extension Dismissable {

    var toolBarItems: [UIBarButtonItem] {
        return [.flexibleSpace, .dismissButton]
    }
}

// MARK: - Dismissable protocol conformance

extension UITextField: Dismissable {}
