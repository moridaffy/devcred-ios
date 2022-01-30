//
//  DevCredProjectCell.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 29.01.2022.
//

import UIKit

class DevCredProjectCell: UITableViewCell {
  private enum Config {
    static let projectImageViewHeight: CGFloat = 100.0
  }

  private let separatorView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .systemGray6
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

    selectionStyle = .none
    backgroundColor = .clear

    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func update(project: DevCredProjectInfo) {
    if let imageUrlString = project.iconUrl,
        let imageUrl = URL(string: imageUrlString) {
      projectLabelLeftConstraint?.constant = Config.projectImageViewHeight + 16.0
      projectImageView.isHidden = false

      projectImageView.kf.setImage(with: imageUrl, options: [.transition(.fade(0.3))])
    } else {
      projectLabelLeftConstraint?.constant = 0.0
      projectImageView.isHidden = true
    }

    let attributedText = NSMutableAttributedString()
    attributedText.append(
      NSAttributedString(
        string: project.name,
        attributes: [.font: UIFont.systemFont(ofSize: 18.0, weight: .semibold)]
      )
    )
    if let subtitle = project.description,
       !subtitle.isEmpty {
      attributedText.append(
        NSAttributedString(
          string: "\n" + subtitle,
          attributes: [.font: UIFont.systemFont(ofSize: 14.0, weight: .regular)]
        )
      )
    }

    projectLabel.attributedText = attributedText
  }

  private func setupLayout() {
    contentView.addSubview(separatorView)
    contentView.addSubview(projectImageView)
    contentView.addSubview(projectLabel)

    let projectLabelLeftConstraint = projectLabel.leftAnchor.constraint(
      equalTo: projectImageView.leftAnchor,
      constant: Config.projectImageViewHeight + 16.0
    )
    self.projectLabelLeftConstraint = projectLabelLeftConstraint

    contentView.addConstraints([
      separatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
      separatorView.leftAnchor.constraint(equalTo: projectImageView.leftAnchor),
      separatorView.rightAnchor.constraint(equalTo: projectLabel.rightAnchor),
      separatorView.heightAnchor.constraint(equalToConstant: 1.0),

      projectImageView.topAnchor.constraint(greaterThanOrEqualTo: separatorView.bottomAnchor, constant: 8.0),
      projectImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16.0),
      projectImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      projectImageView.heightAnchor.constraint(equalToConstant: Config.projectImageViewHeight),
      projectImageView.widthAnchor.constraint(equalToConstant: Config.projectImageViewHeight),

      projectLabel.topAnchor.constraint(greaterThanOrEqualTo: separatorView.bottomAnchor, constant: 8.0),
      projectLabelLeftConstraint,
      projectLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16.0),
      projectLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
}
