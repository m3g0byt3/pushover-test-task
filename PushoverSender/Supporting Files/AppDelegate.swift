//
//  AppDelegate.swift
//  PushoverSender
//
//  Created by m3g0byt3 on 01/09/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var configurator: Configurator<AppAssembly>?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        configure()
        return true
    }

    // Perform initial DI
    private func configure() {
        window = UIWindow(frame: UIScreen.main.bounds)
        configurator = Configurator<AppAssembly>()

        let scene = configurator?.getScene(.main)

        window?.rootViewController = scene?.presentableEntity
        window?.makeKeyAndVisible()
    }
}
