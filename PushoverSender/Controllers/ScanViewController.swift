//
//  ScanViewController.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 02/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

/// QR scanner scene.
final class ScanViewController: UIViewController, Presentable {

    // MARK: - IBOutlets and UI

    /// Layer with live preview from camera.
    private weak var previewLayer: CALayer?

    private lazy var cancelButton: UIButton = { this in
        let image = R.image.closeButton()?.withRenderingMode(.alwaysTemplate)
        this.tintColor = Constants.ScanScene.textColor
        this.setImage(image, for: .normal)
        this.addTarget(self, action: #selector(cancelButtonHandler(_:)), for: .touchUpInside)
        return this
    }(UIButton(type: .system))

    private lazy var errorLabel: UILabel = { this in
        this.textColor = Constants.ScanScene.textColor
        this.numberOfLines = 0
        this.textAlignment = .center
        return this
    }(UILabel())

    // MARK: - Dependencies

    /// Service to perform QR code recognition.
    var scanService: ScanService!
    // swiftlint:disable:previous implicitly_unwrapped_optional

    /// Completion handler called on QR code recognition.
    var completion: Constants.ScanCompletion?

    // MARK: - Public properties

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        scanService.delegate = self
        scanService.prepare()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scanService.start()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scanService.stop()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = view.bounds
    }

    // MARK: - Public API

    override func updateViewConstraints() {
        cancelButton.snp.updateConstraints { maker in
            let ratio = Constants.ScanScene.cancelButtonBottomRatio
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().multipliedBy(ratio)
        }
        super.updateViewConstraints()
    }

    // MARK: - Private API

    /// Perform initial UI setup.
    private func setupUI() {
        view.backgroundColor = Constants.ScanScene.backgroundColor
        view.addSubview(cancelButton)
        view.setNeedsUpdateConstraints()
    }

    /// Handle scanning errors.
    /// - Parameter error: An error.
    private func handleError(_ error: Error) {
        view.addSubview(errorLabel)
        errorLabel.text = error.localizedDescription
        errorLabel.snp.makeConstraints { maker in
            maker.leading.trailing.centerY.equalToSuperview()
        }
    }

    // MARK: - Control handlers

    /// Control handler for an `UIButton` instance.
    /// - Parameter sender: `UIButton` instance.
    @objc private func cancelButtonHandler(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: - ScanServiceDelegate protocol conformance

extension ScanViewController: ScanServiceDelegate {

    func scanner(_ scanner: ScanService, didFailWith error: ScannerError) {
        handleError(error)
    }

    func scanner(_ scanner: ScanService, didSetupPreview layer: CALayer) {
        view.layer.insertSublayer(layer, below: cancelButton.layer)
        scanService.start()
        previewLayer = layer
    }

    func scanner(_ scanner: ScanService, didRecognizedCode value: String) {
        completion?(value)
    }
}
