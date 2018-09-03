//
//  Customizable.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 04/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

/// Use POP for aggregation.
/// Customization details should be provided by the inheritors of this protocol.
/// Customization details should be applied in the `customize()` func, see example below:
/// ```
/// protocol ColoredView: Customizable {
///    var color: UIColor { get }
/// }
///
/// protocol BlackView: ColoredView {}
///
/// extension BlackView {
///    var color: UIColor { return .black }
/// }
///
/// extension UIView: Customizable {
///    func customize() {
///        if let custom = self as? ColoredView {
///            self.backgroundColor = custom.color
///        }
///    }
///
///    override open func awakeFromNib() {
///        super.awakeFromNib()
///        customize()
///    }
/// }
///
/// final class CustomView: UIView, BlackView {}
/// ```
protocol Customizable {

    /// Called from `awakeFromNib()` in the protocol extensions, don't call directly.
    func customize()
}

extension UITextField: Customizable {

    func customize() {
        let toolBar = UIToolbar(frame: .zero)

        toolBar.items = toolBarItems
        toolBar.sizeToFit()

        inputAccessoryView = toolBar
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        customize()
    }
}

extension UITextView: Customizable {

    func customize() {
        if let customizable = self as? Dismissable {
            let toolBar = UIToolbar(frame: .zero)

            toolBar.items = customizable.toolBarItems
            toolBar.sizeToFit()

            inputAccessoryView = toolBar
        }
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        customize()
    }
}
