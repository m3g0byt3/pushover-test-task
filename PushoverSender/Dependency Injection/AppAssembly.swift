//
//  AppAssembly.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

enum AppAssembly: Assembly {

    case main(Configurator<AppAssembly>?)
    case compose(UIBarButtonItem)

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

            composeViewController.modalPresentationStyle = .popover
            composeViewController.popoverPresentationController?.barButtonItem = barButtonItem
            composeViewController.presentationController?.delegate = composeViewController

            return composeViewController
        }
    }

    var networkService: NetworkService {
        fatalError("Not implemented yet")
    }

    var databaseService: DatabaseService {
        fatalError("Not implemented yet")
    }
}
