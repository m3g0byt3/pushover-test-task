//
//  ComposeViewController.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

// TODO: Disable send button when no valid input provided

/// Message composing scene.
final class ComposeViewController: UIViewController, Presentable {

    // MARK: - IBOutlets and UI

    @IBOutlet private weak var recipientTextField: UITextField!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var messageTextView: MessageTextView!

    private lazy var sendButton: UIBarButtonItem = {
        let selector = #selector(barButtonHandler(_:))
        let image = R.image.send()
        return UIBarButtonItem(image: image, style: .plain, target: self, action: selector)
    }()

    private lazy var cancelButton: UIBarButtonItem = {
        let selector = #selector(barButtonHandler(_:))
        return UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: selector)
    }()

    private lazy var scanButton: UIBarButtonItem = {
        let selector = #selector(barButtonHandler(_:))
        let image = R.image.scanButton()
        return UIBarButtonItem(image: image, style: .plain, target: self, action: selector)
    }()

    private var firstResponders: [UIResponder] {
        return [recipientTextField, titleTextField, messageTextView]
    }

    // MARK: - Dependencies

    /// Service locator
    var configurator: Configurator<AppAssembly>?

    /// Service to perform network requests.
    var networkService: NetworkService!
    // swiftlint:disable:previous implicitly_unwrapped_optional

    /// Database service, provides persistence
    var databaseService: AnyDatabaseService<HistoryItem>!
    // swiftlint:disable:previous implicitly_unwrapped_optional

    // MARK: - Public properties

    override var preferredContentSize: CGSize {
        get { return Constants.ComposeScene.preferredContentSize }
        set { super.preferredContentSize = newValue }
    }

    // MARK: - Private properties

    /// Mutable struct, wrapper for the composed message.
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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        recipientTextField.becomeFirstResponder()
    }

    // MARK: - Private API

    /// Perform initial UI setup.
    private func setupUI() {
        edgesForExtendedLayout = []
        navigationItem.rightBarButtonItem = sendButton
        navigationItem.leftBarButtonItem = cancelButton
        messageTextView.inputAccessoryItems.insert(scanButton, at: 0)
    }

    /// Perform network request using `NetworkService` dependency.
    /// - Parameter message: Wrapper for the composed message.
    private func performNetworkRequest(for message: Message?) {
        guard let message = message else { return }
        networkService.send(message: message) { [weak self] result in
            let alertData: (title: String, message: String)
            let historyItem: HistoryItem
            // Extract data from result
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

    /// Show QR scanner UI.
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

    /// Control handler for an `UIBarButtonItem` instance.
    /// - Parameter sender: `UIBarButtonItem` instance.
    @objc private func barButtonHandler(_ sender: UIBarButtonItem) {
        switch sender {
        case sendButton: performNetworkRequest(for: message)
        case cancelButton: navigationController?.dismiss(animated: true)
        case scanButton: showScanner()
        default: break
        }
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
        // Switch to the next responder.
        if let index = firstResponders.index(of: textField) {
            firstResponders[safeAfter: index]?.becomeFirstResponder()
        }
        return true
    }
}
