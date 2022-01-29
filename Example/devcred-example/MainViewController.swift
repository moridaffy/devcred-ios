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
    // TODO
    print("credentialsButtonTapped")
  }
}
