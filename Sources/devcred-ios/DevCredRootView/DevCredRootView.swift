//
//  DevCredRootView.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 29.01.2022.
//

import UIKit

public enum DevCredRootView {
  public static func build(_ config: DevCredConfig) -> Controller {
    let viewModel = Model(config: config)
    let viewController = Controller(viewModel: viewModel)
    return viewController
  }

  public static func present(config: DevCredConfig, from presentingViewController: UIViewController) {
    let controller = build(config)

    switch config.presentationType {
    case .modal:
      let navigationController = UINavigationController(rootViewController: controller)
      presentingViewController.present(navigationController, animated: true, completion: nil)
    case .push:
      guard let navigationController = presentingViewController.navigationController else {
        print("Push presentation type selected, but presenting view controller is not embedded in UINavigationController")
        return
      }

      navigationController.pushViewController(controller, animated: true)
    }
  }
}
