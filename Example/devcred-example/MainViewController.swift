//
//  MainViewController.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 29.01.2022.
//

import UIKit

class MainViewController: UIViewController {
  private let textLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = Locale.current.languageCode //"Your app content goes here..."
    label.textAlignment = .center
    label.textColor = .label
    return label
  }()

  private let credentialsButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Credentials", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    return button
  }()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    view.backgroundColor = .systemBackground

    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    credentialsButton.addTarget(self, action: #selector(credentialsButtonTapped), for: .touchUpInside)
  }

  private func setupLayout() {
    view.addSubview(textLabel)
    view.addSubview(credentialsButton)

    view.addConstraints([
      textLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32.0),
      textLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32.0),
      textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

      credentialsButton.topAnchor.constraint(greaterThanOrEqualTo: textLabel.bottomAnchor, constant: 8.0),
      credentialsButton.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: 32.0),
      credentialsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32.0),
      credentialsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }

  @objc private func credentialsButtonTapped() {
    let localSource: DevCredInfoSource = .local(
      developer: DevCredDeveloperInfo(
        name: "Maxim Skryabin",
        description: "iOS developer",
        imageUrl: "https://mxm.codes/wp-content/uploads/2022/01/me.jpg"
      ),
      projects: [
        .init(name: "FoodRocket1", description: "FoodRocket – стартап, работающий на территории США, позволяющий пользователям заказывать доставку свежих продуктов, готовых блюд и предметов домашнего обихода", iconUrl: "https://mxm.codes/wp-content/uploads/2022/01/ios_foodrocket_icon-e1643113439817-300x300.png", linkUrl: nil),
        .init(name: "FoodRocket2", description: "FoodRocket – стартап, работающий на территории США, позволяющий пользователям заказывать доставку свежих продуктов, готовых блюд и предметов домашнего обихода", iconUrl: "https://mxm.codes/wp-content/uploads/2022/01/ios_foodrocket_icon-e1643113439817-300x300.png", linkUrl: nil),
        .init(name: "FoodRocket3", description: "FoodRocket – стартап, работающий на территории США, позволяющий пользователям заказывать доставку свежих продуктов, готовых блюд и предметов домашнего обихода", iconUrl: "https://mxm.codes/wp-content/uploads/2022/01/ios_foodrocket_icon-e1643113439817-300x300.png", linkUrl: nil)
      ])

    // https://www.npoint.io/docs/78727e638b2d4a5430cf
    // https://api.npoint.io/78727e638b2d4a5430cf
    let remoteSource: DevCredInfoSource = .remote(url: "https://api.npoint.io/78727e638b2d4a5430cf")

    let config = DevCredConfig(
      infoSource: remoteSource,
      presentationType: .modal
    )
    DevCredRootView.present(config: config, from: self)
  }
}
