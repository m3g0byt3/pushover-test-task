//
//  QRCodeScanner.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 02/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import AVFoundation

final class QRCodeScanner: NSObject, ScanService {

    // MARK: - Constants

    private static let queueIdentifier = "com.m3g0byt3.qrCodeScanner"

    // MARK: - Public properties

    weak var delegate: ScanServiceDelegate?

    // MARK: - Private properties

    private let queue = DispatchQueue(label: QRCodeScanner.queueIdentifier)
    private var captureSession: AVCaptureSession?

    // MARK: - Public API

    func prepare() {
        checkStatus()
    }

    func start() {
        captureSession?.startRunning()
    }

    func stop() {
        captureSession?.stopRunning()
    }

    // MARK: - Private API

    private func checkStatus() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: setupCameraDevice()
        case .notDetermined: requestAccess()
        case .denied, .restricted: delegate?.scanner(self, didFailWith: .noAccess)
        }
    }

    private func requestAccess() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isAllowed in
            if isAllowed {
                self?.setupCameraDevice()
            } else {
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    self?.delegate?.scanner(strongSelf, didFailWith: .noAccess)
                }
            }
        }
    }

    private func setupCameraDevice() {
        guard
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
            let input = try? AVCaptureDeviceInput(device: device)
        else {
            DispatchQueue.main.async {
                self.delegate?.scanner(self, didFailWith: .noDevice)
            }
            return
        }

        let session = AVCaptureSession()
        session.addInput(input)

        let output = AVCaptureMetadataOutput()
        session.addOutput(output)

        output.setMetadataObjectsDelegate(self, queue: queue)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

        let preview = AVCaptureVideoPreviewLayer(session: session)
        preview.videoGravity = .resizeAspectFill

        DispatchQueue.main.async {
            self.delegate?.scanner(self, didSetupPreview: preview)
        }

        captureSession = session
    }

    deinit {
        stop()
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate protocol conformace

extension QRCodeScanner: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        guard
            let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
            let value = object.stringValue
        else { return }

        DispatchQueue.main.async {
            self.delegate?.scanner(self, didRecognizedCode: value)
        }
    }
}
