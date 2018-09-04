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

    // MARK: - Public API

    /// New `UIBarButtonItem` with type of `.flexibleSpace`.
    static var flexibleSpace: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }

    /// New `UIBarButtonItem` with type of `.fixedSpace`.
    static var fixedSpace: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    }

    /// New `UIBarButtonItem` with type of `.done` that will resign current First Responder.
    static var dismissButton: UIBarButtonItem {
        let selector = #selector(dismissHandler(_:))
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: selector)
    }

    // MARK: - Private API

    @objc private static func dismissHandler(_ sender: UIBarButtonItem) {
        UIResponder.current?.resignFirstResponder()
    }
}
