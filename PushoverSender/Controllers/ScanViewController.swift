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

final class ScanViewController: UIViewController, Presentable {

    // MARK: - Private properties

    private weak var previewLayer: CALayer?

    private var cancelButton: UIButton = { this in
        let image = R.image.closeButton()?.withRenderingMode(.alwaysTemplate)
        this.setImage(image, for: .normal)
        this.tintColor = .lightGray
        this.addTarget(self, action: #selector(cancelButtonHandler(_:)), for: .touchUpInside)
        return this
    }(UIButton(type: .system))

    // MARK: - Public properties

    /// Service to perform QR code recognition.
    var scanService: ScanService!
    // swiftlint:disable:previous implicitly_unwrapped_optional

    var completion: Constants.ScanCompletion?

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
            let ratio = Constants.Interface.cancelButtonBottomRatio
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().multipliedBy(ratio)
        }
        super.updateViewConstraints()
    }

    // MARK: - Private API

    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(cancelButton)
        view.setNeedsUpdateConstraints()
    }

    @objc private func cancelButtonHandler(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: - ScanServiceDelegate protocol conformace

extension ScanViewController: ScanServiceDelegate {

    func scanner(_ scanner: ScanService, didFailWith error: ScannerError) {
        print(error)
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
