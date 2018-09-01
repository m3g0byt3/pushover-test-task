//
//  ComposeViewController.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

class ComposeViewController: UIViewController, Presentable {}

    // MARK: - Public properties

    /// Service to perform network requests.
    var networkService: NetworkService!
    // swiftlint:disable:previous implicitly_unwrapped_optional
}

// MARK: - UIAdaptivePresentationControllerDelegate protocol conformace

extension ComposeViewController: UIAdaptivePresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
