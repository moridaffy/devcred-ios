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

  init(
    infoSource: DevCredInfoSource,
    presentationType: PresentationType = .modal,
    background: BackgroundType = .color(nil),
    accentColor: UIColor = .systemBlue
  ) {
    self.infoSource = infoSource

    self.presentationType = presentationType
    self.background = background

    self.accentColor = accentColor
  }
}

enum DevCredInfoSource {
  case local(developer: DevCredDeveloperInfo, projects: [DevCredProjectInfo])
  case remote(url: String)
}

struct DevCredRemoteInfo: Decodable {
  let developer: DevCredDeveloperInfo?
  let projects: [DevCredProjectInfo]?
}

struct DevCredDeveloperInfo: Decodable, Hashable {
  let name: String
  let description: String?
  let imageUrl: String?

  enum CodingKeys: String, CodingKey {
    case name
    case description
    case imageUrl = "image_url"
  }

  init(from decoder: Decoder) throws {
    let currentLanguageCode = Locale.current.languageCode ?? "en"

    let container = try decoder.container(keyedBy: CodingKeys.self)

    if let nameDictionary = try? container.decode([String: String].self, forKey: .name) {
      self.name = nameDictionary[currentLanguageCode] ?? nameDictionary["en"] ?? nameDictionary.first?.value ?? "Unexpected name dictionary"
    } else if let nameString = try? container.decode(String.self, forKey: .name) {
      self.name = nameString
    } else {
      self.name = "Unexpected name value"
    }

    if let descriptionDictionary = try? container.decode([String: String].self, forKey: .description) {
      self.description = descriptionDictionary[currentLanguageCode] ?? descriptionDictionary["en"] ?? descriptionDictionary.first?.value ?? "Unexpected description dictionary"
    } else if let descriptionString = try? container.decode(String.self, forKey: .description) {
      self.description = descriptionString
    } else {
      self.description = "Unexpected description value"
    }

    self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
  }

  init(name: String, description: String?, imageUrl: String?) {
    self.name = name
    self.description = description
    self.imageUrl = imageUrl
  }
}

struct DevCredProjectInfo: Decodable, Hashable {
  let name: String
  let description: String?
  let iconUrl: String?
  let linkUrl: String?

  enum CodingKeys: String, CodingKey {
    case name
    case description
    case iconUrl = "icon_url"
    case linkUrl = "link_url"
  }

  init(from decoder: Decoder) throws {
    let currentLanguageCode = Locale.current.languageCode ?? "en"

    let container = try decoder.container(keyedBy: CodingKeys.self)

    if let nameDictionary = try? container.decode([String: String].self, forKey: .name) {
      self.name = nameDictionary[currentLanguageCode] ?? nameDictionary["en"] ?? nameDictionary.first?.value ?? "Unexpected name dictionary"
    } else if let nameString = try? container.decode(String.self, forKey: .name) {
      self.name = nameString
    } else {
      self.name = "Unexpected name value"
    }

    if let descriptionDictionary = try? container.decode([String: String].self, forKey: .description) {
      self.description = descriptionDictionary[currentLanguageCode] ?? descriptionDictionary["en"] ?? descriptionDictionary.first?.value ?? "Unexpected description dictionary"
    } else if let descriptionString = try? container.decode(String.self, forKey: .description) {
      self.description = descriptionString
    } else {
      self.description = "Unexpected description value"
    }

    self.iconUrl = try container.decodeIfPresent(String.self, forKey: .iconUrl)
    self.linkUrl = try container.decodeIfPresent(String.self, forKey: .linkUrl)
  }

  init(name: String, description: String?, iconUrl: String?, linkUrl: String?) {
    self.name = name
    self.description = description
    self.iconUrl = iconUrl
    self.linkUrl = linkUrl
  }
}

extension DevCredConfig {
  enum PresentationType {
    case modal
    case push
  }

  enum BackgroundType {
    case color(UIColor?)
    case blur
  }
}
