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

    case main
    case compose

    var scene: Presentable {
        switch self {

        case .main:
            let sentViewController = SentViewController.fromNib()
            let scheduledViewController = ScheduledViewController.fromNib()
            let tabBarController = UITabBarController()

            sentViewController.navigationItem.title = Constants.Interface.sentTitle
            scheduledViewController.navigationItem.title = Constants.Interface.scheduledTitle

            sentViewController.tabBarItem = UITabBarItem(title: Constants.Interface.sentTitle,
                                                         image: R.image.sent(),
                                                         selectedImage: nil)
            scheduledViewController.tabBarItem = UITabBarItem(title: Constants.Interface.scheduledTitle,
                                                              image: R.image.scheduled(),
                                                              selectedImage: nil)

            tabBarController.viewControllers = [sentViewController, scheduledViewController]
                .map(UINavigationController.init)

            return tabBarController

        case .compose:
            return ComposeViewController.fromNib()
        }
    }

    var networkService: NetworkService {
        fatalError("Not implemented yet")
    }

    var databaseService: DatabaseService {
        fatalError("Not implemented yet")
    }
}
