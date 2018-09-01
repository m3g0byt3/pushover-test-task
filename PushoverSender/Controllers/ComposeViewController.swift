//
//  ComposeViewController.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

final class ComposeViewController: UIViewController, Presentable {

    // MARK: - IBoutlets

    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var scheduleSwitch: UISwitch!
    @IBOutlet private weak var scheduleLabel: UILabel!

    // MARK: - Public properties

    /// Service to perform network requests.
    var networkService: NetworkService!
    // swiftlint:disable:previous implicitly_unwrapped_optional

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        preferredContentSize = calculatePreferredContentSize()
    }

    // MARK: - Public API

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupUI()
    }

    // MARK: - Private API

    private func setupUI() {
        let sendSelector = #selector(sendButtonHandler(_:))
        let cancelSelector = #selector(cancelButtonHandler(_:))
        let scheduleSelector = #selector(scheduleSwitchHandler(_:))
        let sendButton = UIBarButtonItem(image: R.image.sent(),
                                         style: .plain,
                                         target: self,
                                         action: sendSelector)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: cancelSelector)
        scheduleSwitch.addTarget(self, action: scheduleSelector, for: .valueChanged)
        navigationItem.rightBarButtonItem = sendButton
        navigationItem.leftBarButtonItem = cancelButton
        // TODO: Placeholder for text view
        textView.layer.borderWidth = Constants.Interface.borderWidth
        textView.layer.cornerRadius = Constants.Interface.cornerRadius
        textView.layer.borderColor = Constants.Interface.borderColor.cgColor
    }

    private func calculatePreferredContentSize() -> CGSize {
        let convertedFrame = view.convert(scheduleSwitch.frame, from: scheduleSwitch)
        let width = super.preferredContentSize.width
        let height = convertedFrame.maxY
        return CGSize(width: width, height: height)
    }

    // MARK: - Control handlers

    @objc private func sendButtonHandler(_ sender: UIBarButtonItem) {
        fatalError("Not implemented yet")
    }

    @objc private func cancelButtonHandler(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }

    @objc private func scheduleSwitchHandler(_ sender: UISwitch) {
        scheduleLabel.textColor = sender.isOn ? .black : .lightGray
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate protocol conformace

extension ComposeViewController: UIAdaptivePresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
