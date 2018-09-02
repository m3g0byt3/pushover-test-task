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

enum AppAssembly: Assembly {

    case main(Configurator<AppAssembly>?)
    case compose(UIBarButtonItem)
    case scan(Constants.ScanCompletion)

    // MARK: - Assembly protocol conformace

    var scene: Presentable {
        switch self {

        case .main(let configurator):
            let sentViewController = SentViewController.fromNib()
            let scheduledViewController = ScheduledViewController.fromNib()
            let tabBarController = UITabBarController()

            sentViewController.navigationItem.title = Constants.Interface.sentTitle
            scheduledViewController.navigationItem.title = Constants.Interface.scheduledTitle
            sentViewController.configurator = configurator

            sentViewController.tabBarItem = UITabBarItem(title: Constants.Interface.sentTitle,
                                                         image: R.image.sent(),
                                                         selectedImage: nil)

            scheduledViewController.tabBarItem = UITabBarItem(title: Constants.Interface.scheduledTitle,
                                                              image: R.image.scheduled(),
                                                              selectedImage: nil)

            tabBarController.viewControllers = [sentViewController, scheduledViewController]
                .map(UINavigationController.init)

            return tabBarController

        case .compose(let barButtonItem):
            let composeViewController = ComposeViewController.fromNib()
            let navigationController = UINavigationController(rootViewController: composeViewController)

            composeViewController.networkService = networkService
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
                                                     plugins: [plugin],
                                                     trackInflights: true)
            return PushoverNetworkService(provider: provider)
        }
    }

    var databaseService: DatabaseService {
        fatalError("Not implemented yet")
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
                let isIndicatorVisible = change == .began
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = isIndicatorVisible
                }
            }
        }
    }
}
