//
//  AppDelegate.swift
//  CategoryViewer
//
//  Created by Mark DiFranco on 2019-05-13.
//  Copyright © 2019 Mark DiFranco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let mainAssembler = MainAssembler()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setupWindow()

        return true
    }

    func setupWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = UIColor.white

        let categoryViewController = mainAssembler.resolver.resolve(CategoryViewController.self)!
        let navController = UINavigationController(rootViewController: categoryViewController)
        navController.navigationBar.prefersLargeTitles = true

        window.rootViewController = navController

        self.window = window
    }
}

