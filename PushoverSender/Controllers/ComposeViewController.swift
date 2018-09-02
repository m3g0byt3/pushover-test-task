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

    @IBOutlet private weak var recipientTextField: UITextField!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var messageTextView: MessageTextView!
    @IBOutlet private weak var scheduleSwitch: UISwitch!
    @IBOutlet private weak var scheduleLabel: UILabel!

    // MARK: - Private properties

    private var firstResponders: [UIResponder] {
        return [recipientTextField, titleTextField, messageTextView]
    }

    private var message: Message? {
        guard
            let key = recipientTextField.text,
            let title = titleTextField.text,
            let message = messageTextView.text
        else { return nil }
        return Message(recipient: Recipient(key: key, device: nil),
                       title: title,
                       message: message)
    }

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
        // TODO: Disable send button when no valid input provided
        let sendButton = UIBarButtonItem(image: R.image.sent(),
                                         style: .plain,
                                         target: self,
                                         action: #selector(sendButtonHandler(_:)))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector(cancelButtonHandler(_:)))
        let scanButton = UIBarButtonItem(image: R.image.scanButton(),
                                         style: .plain,
                                         target: self,
                                         action: #selector(scanButtonHandler(_:)))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneButtonHandler(_:)))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)

        scheduleSwitch.addTarget(self, action: #selector(scheduleSwitchHandler(_:)), for: .valueChanged)
        navigationItem.rightBarButtonItem = sendButton
        navigationItem.leftBarButtonItem = cancelButton
        messageTextView.inputAccessoryItems = [space, scanButton, doneButton]
    }

    private func calculatePreferredContentSize() -> CGSize {
        let convertedFrame = view.convert(scheduleSwitch.frame, from: scheduleSwitch)
        let width = super.preferredContentSize.width
        let height = convertedFrame.maxY
        return CGSize(width: width, height: height)
    }

    private func performNetworkRequest(for message: Message) {
        networkService.send(message: message) { [weak self] result in
            switch result {
            case .success(let response):
                let parentViewController = self?.navigationController?.presentingViewController
                self?.navigationController?.dismiss(animated: true)
                parentViewController?.presentAlert(title: "Done",
                                                   message: "Message sent successfully with token: \(response.request)")
            case .failure(let error):
                self?.presentAlert(title: "Error",
                                   message: "Unable to send message due to error: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Control handlers

    @objc private func sendButtonHandler(_ sender: UIBarButtonItem) {
        guard let message = message else { return }
        performNetworkRequest(for: message)
    }

    @objc private func cancelButtonHandler(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }

    @objc private func scheduleSwitchHandler(_ sender: UISwitch) {
        // TODO: Add actual implementation
        scheduleLabel.textColor = sender.isOn ? .black : .lightGray
    }

    @objc private func doneButtonHandler(_ sender: UIBarButtonItem) {
        UIResponder.current?.resignFirstResponder()
    }

    @objc private func scanButtonHandler(_ sender: UIBarButtonItem) {
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate protocol conformace

extension ComposeViewController: UIAdaptivePresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: - UITextFieldDelegate protocol conformace

extension ComposeViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let index = firstResponders.index(of: textField) {
            firstResponders[safeAfter: index]?.becomeFirstResponder()
        }
        return true
    }
}
