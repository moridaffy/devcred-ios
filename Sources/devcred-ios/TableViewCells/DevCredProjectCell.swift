//
//  DevCredProjectCell.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 29.01.2022.
//

import UIKit

class DevCredProjectCell: UITableViewCell {
  private enum Config {
    static let projectImageViewHeight: CGFloat = 80.0
  }

  private let projectImageShadowView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    view.layer.shadowOpacity = 0.25
    view.layer.shadowOffset = .zero
    view.layer.shadowRadius = 5.0
    return view
  }()

  private let projectImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 22.0
    imageView.layer.masksToBounds = true
    imageView.backgroundColor = .systemGray3
    return imageView
  }()

  private let projectLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()

  private var projectLabelLeftConstraint: NSLayoutConstraint?

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    backgroundColor = .clear

    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func update(project: DevCredProjectInfo, accentColor: UIColor, textColor: UIColor) {
    if let imageUrlString = project.iconUrl,
        let imageUrl = URL(string: imageUrlString) {
      projectLabelLeftConstraint?.constant = Config.projectImageViewHeight + 16.0
      projectImageShadowView.isHidden = false
      projectImageShadowView.layer.shadowColor = accentColor.cgColor

      projectImageView.kf.setImage(with: imageUrl, options: [.transition(.fade(0.3))])
    } else {
      projectLabelLeftConstraint?.constant = 0.0
      projectImageShadowView.isHidden = true
    }

    let attributedText = NSMutableAttributedString()
    attributedText.append(
      NSAttributedString(
        string: project.name,
        attributes: [
          .font: UIFont.systemFont(ofSize: 20.0, weight: .semibold),
          .foregroundColor: textColor
        ]
      )
    )
    if let subtitle = project.description,
       !subtitle.isEmpty {
      attributedText.append(
        NSAttributedString(
          string: "\n" + subtitle,
          attributes: [
            .font: UIFont.systemFont(ofSize: 14.0, weight: .regular),
            .foregroundColor: textColor.withAlphaComponent(0.5)
          ]
        )
      )
    }

    projectLabel.attributedText = attributedText

    if let link = project.linkUrl,
       !link.isEmpty {
      accessoryType = .detailButton
      selectionStyle = .default
    } else {
      accessoryType = .none
      selectionStyle = .none
    }
  }

  private func setupLayout() {
    contentView.addSubview(projectImageShadowView)
    projectImageShadowView.addSubview(projectImageView)
    contentView.addSubview(projectLabel)

    let projectLabelLeftConstraint = projectLabel.leftAnchor.constraint(
      equalTo: projectImageShadowView.leftAnchor,
      constant: Config.projectImageViewHeight + 16.0
    )
    self.projectLabelLeftConstraint = projectLabelLeftConstraint

    contentView.addConstraints([
      projectImageShadowView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16.0),
      projectImageShadowView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16.0),
      projectImageShadowView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      projectImageShadowView.heightAnchor.constraint(equalToConstant: Config.projectImageViewHeight),
      projectImageShadowView.widthAnchor.constraint(equalToConstant: Config.projectImageViewHeight),

      projectImageView.topAnchor.constraint(equalTo: projectImageShadowView.topAnchor),
      projectImageView.leftAnchor.constraint(equalTo: projectImageShadowView.leftAnchor),
      projectImageView.rightAnchor.constraint(equalTo: projectImageShadowView.rightAnchor),
      projectImageView.bottomAnchor.constraint(equalTo: projectImageShadowView.bottomAnchor),

      projectLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16.0),
      projectLabelLeftConstraint,
      projectLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16.0),
      projectLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
}
