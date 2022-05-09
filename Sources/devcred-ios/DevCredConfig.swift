//
//  DevCredConfig.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 29.01.2022.
//

import UIKit

public struct DevCredConfig {
  let infoSource: DevCredInfoSource

  let excludedBundleId: String?
  let presentationType: PresentationType
  let background: BackgroundType

  let accentColor: UIColor
  let textColor: UIColor

  public init(
    infoSource: DevCredInfoSource,
    excludedBundleId: String? = nil,
    presentationType: PresentationType = .modal,
    background: BackgroundType = .color(nil),
    accentColor: UIColor = .systemBlue,
    textColor: UIColor = .label
  ) {
    self.infoSource = infoSource

    self.excludedBundleId = excludedBundleId
    self.presentationType = presentationType
    self.background = background

    self.accentColor = accentColor
    self.textColor = textColor
  }
}

public enum DevCredInfoSource {
  case local(title: String?, developer: DevCredDeveloperInfo, projects: [DevCredProjectInfo])
  case remote(url: String)
}

public extension DevCredConfig {
  enum PresentationType {
    case modal
    case push
  }

  enum BackgroundType {
    case color(UIColor?)
    case blurDark
    case blurLight
  }
}
