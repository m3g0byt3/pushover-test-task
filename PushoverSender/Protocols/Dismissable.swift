//
//  Dismissable.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 04/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

protocol Dismissable: Customizable {

    var toolBarItems: [UIBarButtonItem] { get }
}

extension Dismissable {

    var toolBarItems: [UIBarButtonItem] {
        return [.flexibleSpace, .dismissButton]
    }
}

extension UITextField: Dismissable {}
