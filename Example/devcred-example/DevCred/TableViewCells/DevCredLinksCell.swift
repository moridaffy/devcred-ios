//
//  DevCredLinksCell.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 31.01.2022.
//

import UIKit

class DevCredLinksCell: UITableViewCell {
  private enum Config {
    static let iconHeight: CGFloat = 50.0
  }

  private let stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 8.0
    stackView.axis = .horizontal
    return stackView
  }()

  private var links: [DevCredDeveloperInfo.SocialLink] = []

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    selectionStyle = .none
    backgroundColor = .clear

    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func update(links: [DevCredDeveloperInfo.SocialLink]) {
    self.links = links

    for view in stackView.arrangedSubviews {
      (view as? UIButton)?.removeTarget(nil, action: nil, for: .allEvents)
      view.removeFromSuperview()
      stackView.removeArrangedSubview(view)
    }

    for i in 0..<links.count {
      let button = getLinkButton(for: links[i])
      button.tag = i + 1
      stackView.addArrangedSubview(button)
    }
  }

  private func setupLayout() {
    contentView.addSubview(stackView)

    contentView.addConstraints([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
      stackView.leftAnchor.constraint(greaterThanOrEqualTo: contentView.leftAnchor, constant: 16.0),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
      stackView.heightAnchor.constraint(equalToConstant: Config.iconHeight),
      stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])
  }

  private func getLinkButton(for link: DevCredDeveloperInfo.SocialLink) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(nil, for: .normal)
    button.setImage(link.type.icon, for: .normal)

    button.addConstraints([
      button.heightAnchor.constraint(equalToConstant: Config.iconHeight),
      button.widthAnchor.constraint(equalToConstant: Config.iconHeight)
    ])

    button.addTarget(self, action: #selector(iconButtonTapped(_:)), for: .touchUpInside)

    return button
  }

  @objc private func iconButtonTapped(_ sender: UIButton) {
    let link = links[sender.tag - 1]

    guard let url = URL(string: link.value) else { return }

    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}
