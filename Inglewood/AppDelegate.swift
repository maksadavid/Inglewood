//
//  AppDelegate.swift
//  Inglewood
//
//  Created by David Maksa on 26.11.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let appCoordinator = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = appCoordinator.rootController
        appCoordinator.start()
        window?.makeKeyAndVisible()
        return true
    }

}

