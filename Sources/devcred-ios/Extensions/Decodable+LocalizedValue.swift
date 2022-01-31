//
//  Decodable+LocalizedValue.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 31.01.2022.
//

import Foundation

extension Decodable {
  static func getLocalizedValue<T: CodingKey>(from container: KeyedDecodingContainer<T>, for key: T) -> String? {
    if let dictionary = try? container.decode([String: String].self, forKey: key) {
      let currentLanguageCode = Locale.languageCodeOrEnglish
      return dictionary[currentLanguageCode] ?? dictionary["en"] ?? dictionary.first?.value ?? "Unexpected dictionary"
    } else if let string = try? container.decode(String.self, forKey: key) {
      return string
    } else {
      return nil
    }
  }
}
