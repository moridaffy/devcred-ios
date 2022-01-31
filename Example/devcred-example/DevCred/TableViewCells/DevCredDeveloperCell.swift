//
//  DevCredDeveloperCell.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 29.01.2022.
//

import UIKit

import Kingfisher

class DevCredDeveloperCell: UITableViewCell {
  private enum Config {
    static let developerImageViewHeight: CGFloat = 150.0
  }

  private let developerImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = Config.developerImageViewHeight / 2.0
    imageView.layer.masksToBounds = true
    imageView.backgroundColor = .systemGray3
    return imageView
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.textColor = .label
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 20.0, weight: .semibold)
    return label
  }()

  private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.textColor = .secondaryLabel
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 14.0, weight: .regular)
    return label
  }()

  private var titleLabelTopConstraint: NSLayoutConstraint?

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    selectionStyle = .none
    backgroundColor = .clear

    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func update(developer: DevCredDeveloperInfo, textColor: UIColor) {
    if let imageUrlString = developer.imageUrl,
        let imageUrl = URL(string: imageUrlString) {
      titleLabelTopConstraint?.constant = Config.developerImageViewHeight + 16.0
      developerImageView.isHidden = false

      developerImageView.kf.setImage(with: imageUrl, options: [.transition(.fade(0.3))])
    } else {
      titleLabelTopConstraint?.constant = 0.0
      developerImageView.isHidden = true
    }

    titleLabel.text = developer.name
    titleLabel.textColor = textColor

    subtitleLabel.text = developer.description
    subtitleLabel.textColor = textColor.withAlphaComponent(0.5)
  }

  private func setupLayout() {
    contentView.addSubview(developerImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(subtitleLabel)

    let titleLabelTopConstraint = titleLabel.topAnchor.constraint(
      equalTo: developerImageView.topAnchor,
      constant: Config.developerImageViewHeight + 16.0
    )
    self.titleLabelTopConstraint = titleLabelTopConstraint

    contentView.addConstraints([
      developerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
      developerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      developerImageView.heightAnchor.constraint(equalToConstant: Config.developerImageViewHeight),
      developerImageView.widthAnchor.constraint(equalToConstant: Config.developerImageViewHeight),

      titleLabelTopConstraint,
      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32.0),
      titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32.0),

      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
      subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
      subtitleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
      subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
    ])
  }
}
