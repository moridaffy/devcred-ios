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

struct DevCredRemoteInfo: Decodable {
  let title: String?
  let developer: DevCredDeveloperInfo?
  let projects: [DevCredProjectInfo]?

  enum CodingKeys: String, CodingKey {
    case title
    case developer
    case projects
  }

  init(from decoder: Decoder) throws {
    let currentLanguageCode = Locale.current.languageCode ?? "en"

    let container = try decoder.container(keyedBy: CodingKeys.self)

    if let titleDictionary = try? container.decode([String: String].self, forKey: .title) {
      self.title = titleDictionary[currentLanguageCode] ?? titleDictionary["en"] ?? titleDictionary.first?.value
    } else if let titleString = try? container.decode(String.self, forKey: .title) {
      self.title = titleString
    } else {
      self.title = nil
    }

    self.developer = try container.decodeIfPresent(DevCredDeveloperInfo.self, forKey: .developer)
    self.projects = try container.decodeIfPresent([DevCredProjectInfo].self, forKey: .projects)
  }

  init(title: String?, developer: DevCredDeveloperInfo?, projects: [DevCredProjectInfo]?) {
    self.title = title
    self.developer = developer
    self.projects = projects
  }
}

struct DevCredDeveloperInfo: Decodable, Hashable {
  let name: String
  let description: String?
  let imageUrl: String?
  let links: [SocialLink]?

  enum CodingKeys: String, CodingKey {
    case name
    case description
    case imageUrl = "image_url"
    case links
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
    self.links = try container.decodeIfPresent([SocialLink].self, forKey: .links)
  }

  init(name: String, description: String?, imageUrl: String?, links: [SocialLink]?) {
    self.name = name
    self.description = description
    self.imageUrl = imageUrl
    self.links = links
  }
}

extension DevCredDeveloperInfo {
  struct SocialLink: Decodable, Hashable {
    let type: LinkType
    let value: String

    enum LinkType: String {
      case web
      case vk
      case dribbble
      case behance
      case instagram
      case youtube
      case telegram
      case linkedin
      case facebook
      case twitter
      case github

      var icon: UIImage? {
        return UIImage(named: "icon_link_\(rawValue)")?.withRenderingMode(.alwaysTemplate)
      }
    }

    enum CodingKeys: String, CodingKey {
      case type
      case value
    }

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)

      if let typeValue = try? container.decode(String.self, forKey: .type) {
        self.type = LinkType(rawValue: typeValue) ?? .web
      } else {
        self.type = .web
      }
      self.value = try container.decode(String.self, forKey: .value)
    }

    init(type: LinkType, value: String) {
      self.type = type
      self.value = value
    }
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
    case blurDark
    case blurLight
  }
}
