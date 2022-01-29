//
//  AppDelegate.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 29.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let viewController = MainViewController()
    let navigationController = UINavigationController(rootViewController: viewController)

    let window = UIWindow()
    window.makeKeyAndVisible()
    window.rootViewController = navigationController
    self.window = window


    return true
  }
}

