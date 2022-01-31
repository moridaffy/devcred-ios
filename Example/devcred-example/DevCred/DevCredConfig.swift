//
//  DevCredConfig.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 29.01.2022.
//

import UIKit

struct DevCredConfig {
  let infoSource: DevCredInfoSource

  let presentationType: PresentationType
  let background: BackgroundType

  let accentColor: UIColor
  let textColor: UIColor

  init(
    infoSource: DevCredInfoSource,
    presentationType: PresentationType = .modal,
    background: BackgroundType = .color(nil),
    accentColor: UIColor = .systemBlue,
    textColor: UIColor = .label
  ) {
    self.infoSource = infoSource

    self.presentationType = presentationType
    self.background = background

    self.accentColor = accentColor
    self.textColor = textColor
  }
}

enum DevCredInfoSource {
  case local(title: String?, developer: DevCredDeveloperInfo, projects: [DevCredProjectInfo])
  case remote(url: String)
}

extension DevCredConfig {
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
