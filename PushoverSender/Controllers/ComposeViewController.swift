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
                       text: message)
    }

    // MARK: - Public properties

    /// Service to perform network requests.
    var networkService: NetworkService!
    // swiftlint:disable:previous implicitly_unwrapped_optional

    var databaseService: AnyDatabaseService<HistoryItem>!

    var configurator: Configurator<AppAssembly>?

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
            let alertData: (title: String, message: String)
            let historyItem: HistoryItem

            switch result {
            case .success(let response):
                historyItem = HistoryItem(message: message, response: response)
                alertData = (response.title, response.message)
            case .failure(let error):
                historyItem = HistoryItem(message: message, error: error)
                alertData = (Constants.ComposeScene.errorTitle,
                             Constants.ComposeScene.errorMessage + error.localizedDescription)
            }
            // Save result
            try? self?.databaseService.save(historyItem)
            // Close this view controller and then show alert
            let parentViewController = self?.navigationController?.presentingViewController
            self?.navigationController?.dismiss(animated: true)
            parentViewController?.presentAlert(title: alertData.title,
                                               message: alertData.message)
        }
    }

    private func showScanner() {
        let completion: Constants.ScanCompletion = { [weak self] value in
            self?.messageTextView.text = value
            self?.navigationController?.presentedViewController?.dismiss(animated: true)
        }
        let scene = configurator?.getScene(.scan(completion))
        guard let viewController = scene?.presentableEntity else { return }
        navigationController?.present(viewController, animated: true)
    }

    // MARK: - Control handlers

    // TODO: Replace with single control handler

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
        showScanner()
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate protocol conformance

extension ComposeViewController: UIAdaptivePresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: - UITextFieldDelegate protocol conformance

extension ComposeViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let index = firstResponders.index(of: textField) {
            firstResponders[safeAfter: index]?.becomeFirstResponder()
        }
        return true
    }
}
