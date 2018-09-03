//
//  UIBarButtonItem+Extensions.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 03/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {

    static var flexibleSpace: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }

    static var fixedSpace: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    }

    static var dismissButton: UIBarButtonItem {
        let selector = #selector(dismissHandler(_:))
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: selector)
    }

    @objc private static func dismissHandler(_ sender: UIBarButtonItem) {
        UIResponder.current?.resignFirstResponder()
    }
}
