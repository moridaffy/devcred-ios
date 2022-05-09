//
//  DevCredConfig.Remote.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 31.01.2022.
//

import UIKit

// MARK: - Remote info

public struct DevCredRemoteInfo: Decodable {
  let title: String?
  let developer: DevCredDeveloperInfo?
  let projects: [DevCredProjectInfo]?

  enum CodingKeys: String, CodingKey {
    case title
    case developer
    case projects
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.title = Self.getLocalizedValue(from: container, for: .title)

    self.developer = try container.decodeIfPresent(DevCredDeveloperInfo.self, forKey: .developer)
    self.projects = try container.decodeIfPresent([DevCredProjectInfo].self, forKey: .projects)
  }

  public init(title: String?, developer: DevCredDeveloperInfo?, projects: [DevCredProjectInfo]?) {
    self.title = title
    self.developer = developer
    self.projects = projects
  }
}

// MARK: - Developer info

public struct DevCredDeveloperInfo: Decodable, Hashable {
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

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.name = Self.getLocalizedValue(from: container, for: .name) ?? "Unexpected name value"
    self.description = Self.getLocalizedValue(from: container, for: .description)

    self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
    self.links = try container.decodeIfPresent([SocialLink].self, forKey: .links)
  }

  public init(name: String, description: String?, imageUrl: String?, links: [SocialLink]?) {
    self.name = name
    self.description = description
    self.imageUrl = imageUrl
    self.links = links
  }
}

public extension DevCredDeveloperInfo {
  struct SocialLink: Decodable, Hashable {
    let type: LinkType
    let value: String

    public enum LinkType: String {
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
        guard let mainBundlePath = Bundle.main.resourcePath,
              let devCredBundle = Bundle(path: mainBundlePath + "/DevCred_DevCred.bundle"),
              let iconPath = devCredBundle.path(forResource: "icon_link_\(rawValue)", ofType: "png") else { return nil }

        return UIImage(contentsOfFile: iconPath)?.withRenderingMode(.alwaysTemplate)
      }
    }

    enum CodingKeys: String, CodingKey {
      case type
      case value
    }

    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)

      if let typeValue = try? container.decode(String.self, forKey: .type) {
        self.type = LinkType(rawValue: typeValue) ?? .web
      } else {
        self.type = .web
      }
      self.value = try container.decode(String.self, forKey: .value)
    }

    public init(type: LinkType, value: String) {
      self.type = type
      self.value = value
    }
  }
}

// MARK: - Project info

public struct DevCredProjectInfo: Decodable, Hashable {
  let name: String
  let description: String?
  let iconUrl: String?
  let linkUrl: String?
  let bundleId: String?

  enum CodingKeys: String, CodingKey {
    case name
    case description
    case iconUrl = "icon_url"
    case linkUrl = "link_url"
    case bundleId = "bundle_id"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.name = Self.getLocalizedValue(from: container, for: .name) ?? "Unexpected name value"
    self.description = Self.getLocalizedValue(from: container, for: .description)

    self.iconUrl = try container.decodeIfPresent(String.self, forKey: .iconUrl)
    self.linkUrl = try container.decodeIfPresent(String.self, forKey: .linkUrl)
    self.bundleId = try container.decodeIfPresent(String.self, forKey: .bundleId)
  }

  public init(name: String, description: String?, iconUrl: String?, linkUrl: String?, bundleId: String? = nil) {
    self.name = name
    self.description = description
    self.iconUrl = iconUrl
    self.linkUrl = linkUrl
    self.bundleId = bundleId
  }
}
