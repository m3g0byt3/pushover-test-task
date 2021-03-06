//
//  AppAssembly.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import Moya
import PKHUD

/// Container with dependencies, provides data to the service locator.
enum AppAssembly: Assembly {

    case main(Configurator<AppAssembly>?)
    case compose(UIBarButtonItem, Configurator<AppAssembly>?)
    case scan(Constants.ScanCompletion)

    // MARK: - Assembly protocol conformance

    var scene: Presentable {
        switch self {

        case .main(let configurator):
            let historyViewController = HistoryViewController.fromNib()

            historyViewController.databaseService = databaseService
            historyViewController.navigationItem.title = Constants.HistoryScene.title
            historyViewController.configurator = configurator

            return UINavigationController(rootViewController: historyViewController)

        case let .compose(barButtonItem, configurator):
            let composeViewController = ComposeViewController.fromNib()
            let navigationController = UINavigationController(rootViewController: composeViewController)

            composeViewController.networkService = networkService
            composeViewController.databaseService = databaseService
            composeViewController.configurator = configurator
            navigationController.modalPresentationStyle = .popover
            navigationController.popoverPresentationController?.barButtonItem = barButtonItem
            navigationController.presentationController?.delegate = composeViewController

            return navigationController

        case .scan(let completion):
            let scanViewController = ScanViewController()

            scanViewController.scanService = QRCodeScanner()
            scanViewController.completion = completion

            return scanViewController
        }
    }

    var networkService: NetworkService {
        switch self {
        case .main, .scan:
            fatalError("No \"\(#function)\" dependency available for this target.")
        case .compose:
            let provider = MoyaProvider<PushoverAPI>(callbackQueue: callbackQueue,
                                                     manager: MoyaProvider<PushoverAPI>.customAlamofireManager(),
                                                     plugins: [plugin],
                                                     trackInflights: true)
            return PushoverNetworkService(provider: provider)
        }
    }

    var databaseService: AnyDatabaseService<HistoryItem> {
        switch self {
        case .scan:
            fatalError("No \"\(#function)\" dependency available for this target.")
        case .main, .compose:
            let databaseService = RealmDatabaseService<HistoryItemModelObject>()
            return AnyDatabaseService(databaseService)
        }
    }

    private var callbackQueue: DispatchQueue {
        switch self {
        case .main, .scan:
            fatalError("No \"\(#function)\" dependency available for this target.")
        case .compose:
            return DispatchQueue.global(qos: .userInitiated)
        }
    }

    private var plugin: PluginType {
        switch self {
        case .main, .scan:
            fatalError("No \"\(#function)\" dependency available for this target.")
        case .compose:
            return NetworkActivityPlugin { change, _ in
                DispatchQueue.main.async {
                    switch change {
                    case .began:
                        UIResponder.current?.resignFirstResponder()
                        UIApplication.shared.isNetworkActivityIndicatorVisible = true
                        HUD.show(.progress)
                    case .ended:
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        HUD.hide()
                    }
                }
            }
        }
    }
}
