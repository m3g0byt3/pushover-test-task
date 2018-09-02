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

class MessageTextView: UITextView {

    // MARK: - Public properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    override var text: String! {
        // Workaround for non-firing notifications when `text` is changed programmatically.
        didSet {
            textDidChange()
        }
    }

    @IBInspectable
    var placeholder: String? {
        get {
            return _placeholder?.text
        }
        set {
            _placeholder?.text = newValue
        }
    }

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

    private weak var _placeholder: UILabel?
    private weak var _toolbar: UIToolbar?

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

    // MARK: - Private API

    private func setupUI() {
        let placeholder = UILabel(frame: .zero)
        let toolBar = UIToolbar(frame: .zero)

        placeholder.textColor = Constants.Interface.placeholderColor
        placeholder.font = font
        addSubview(placeholder)
        _placeholder = placeholder

        layer.borderWidth = Constants.Interface.borderWidth
        layer.cornerRadius = Constants.Interface.cornerRadius
        layer.borderColor = Constants.Interface.borderColor.cgColor

        inputAccessoryView = toolBar
        _toolbar = toolBar
    }

    private func setupNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: NSNotification.Name.UITextViewTextDidChange,
                                               object: nil)
    }

    @objc private func textDidChange() {
        guard let placeholder = _placeholder else { return }
        let isHidden = !text.isEmpty

        if placeholder.isHidden != isHidden {
            UIView.animate(withDuration: Constants.Interface.animationDuration) {
                placeholder.isHidden = isHidden
            }
        }
    }
}
