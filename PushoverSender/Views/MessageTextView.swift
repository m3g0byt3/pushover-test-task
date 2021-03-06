//
//  MessageTextView.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 02/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class MessageTextView: UITextView, Dismissable {

    // MARK: - Public properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    override var text: String! {
        // Workaround for non-firing notifications when `text` is changed programmatically.
        didSet {
            textDidChange()
        }
    }

    /// Placeholder text.
    @IBInspectable
    var placeholder: String? {
        get {
            return _placeholder?.text
        }
        set {
            _placeholder?.text = newValue
        }
    }

    /// An array of `UIBarButtonItem` items in `inputAccessoryView`.
    var inputAccessoryItems: [UIBarButtonItem] {
        get {
            return _toolbar?.items ?? []
        }
        set {
            _toolbar?.items = newValue
            _toolbar?.sizeToFit()
        }
    }

    // MARK: - Private properties

    /// Placeholder label.
    private weak var _placeholder: UILabel?

    /// Custom `inputAccessoryView`.
    private weak var _toolbar: UIToolbar? {
        return inputAccessoryView as? UIToolbar
    }

    // MARK: - Initialization

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        setupNotification()
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
        setupNotification()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Public API

    override func updateConstraints() {
        let xInset = Constants.Interface.xInset
        let yInset = font?.pointSize ?? 0

        _placeholder?.snp.updateConstraints { maker in
            maker.leading.equalToSuperview().inset(xInset)
            maker.top.equalToSuperview().inset(yInset / Constants.Interface.yInsetDivider)
        }

        super.updateConstraints()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupUI()
    }

    // MARK: - Private API

    /// Perform initial UI setup.
    private func setupUI() {
        let placeholder = UILabel(frame: .zero)

        placeholder.textColor = Constants.Interface.placeholderColor
        placeholder.font = font
        addSubview(placeholder)
        _placeholder = placeholder

        layer.borderWidth = Constants.Interface.borderWidth
        layer.cornerRadius = Constants.Interface.cornerRadius
        layer.borderColor = Constants.Interface.borderColor.cgColor
    }

    /// Subscribe to `UITextViewTextDidChange` notifications.
    private func setupNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: NSNotification.Name.UITextViewTextDidChange,
                                               object: nil)
    }

    /// Handle `UITextViewTextDidChange` notifications.
    @objc private func textDidChange() {
        guard let placeholder = _placeholder else { return }
        let isHidden = !text.isEmpty

        if placeholder.isHidden != isHidden {
            placeholder.isHidden = isHidden
        }
    }
}
