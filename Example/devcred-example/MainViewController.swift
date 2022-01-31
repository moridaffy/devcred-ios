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
    label.text = "Your app content goes here..."
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
      title: "About me",
      developer: DevCredDeveloperInfo(
        name: "Maxim Skryabin",
        description: "iOS developer",
        imageUrl: "https://mxm.codes/wp-content/uploads/2022/01/me.jpg",
        links: nil
      ),
      projects: [
        .init(
          name: "I Don't Smoke",
          description: "I Don’t Smoke! is an application created specifically to help you get rid of a bad habit! Thanks to many counters and daily tips and motivators, this process will become even easier!",
          iconUrl: "https://mxm.codes/wp-content/uploads/2022/01/ios_idontsmoke_icon-300x300.png",
          linkUrl: "https://apps.apple.com/app/id1450987019"
        ),
        .init(
          name: "Seven",
          description: "The game “Seven” is a unique alcohol game, thanks to which you can “rock” any party! If earlier you had to carry a deck of cards with you, now this game is always in your pocket :)",
          iconUrl: "https://mxm.codes/wp-content/uploads/2022/01/icon_seven_icon-300x300.png",
          linkUrl: "https://apps.apple.com/app/id1206995223"
        ),
        .init(
          name: "Health+",
          description: "Simple app for writing your workouts to Apple Health if using system app doesn’t fit your needs (for example, your workout type is not present in Apple’s app)",
          iconUrl: "https://mxm.codes/wp-content/uploads/2022/01/ios_healthplus_icon-e1642241855397-300x300.png",
          linkUrl: "https://apps.apple.com/app/id1480839127"
        )
      ])

    let config = DevCredConfig(
      infoSource: localSource,
      presentationType: .modal,
      background: .blurDark,
      accentColor: .red,
      textColor: .white
    )
    DevCredRootView.present(config: config, from: self)
  }
}
