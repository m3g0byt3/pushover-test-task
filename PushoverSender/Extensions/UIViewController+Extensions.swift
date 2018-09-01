//
//  UIViewController+Extensions.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    private static func _fromNib<T: UIViewController>() -> T {
        let nibName = String(describing: self)
        guard let viewController = self.init(nibName: nibName, bundle: nil) as? T else {
            fatalError("Unable to init \(self) from NIB file \(nibName)")
        }
        return viewController
    }

    static func fromNib() -> Self {
        return _fromNib()
    }

    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: Constants.Interface.alertCloseButtonTitle, style: .default)

        alert.addAction(closeAction)
        present(alert, animated: true)
    }
}
