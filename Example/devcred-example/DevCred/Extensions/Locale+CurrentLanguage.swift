//
//  Locale+CurrentLanguage.swift
//  devcred-example
//
//  Created by Maxim Skryabin on 31.01.2022.
//

import Foundation

extension Locale {
  static var languageCodeOrEnglish: String {
    Locale.current.languageCode ?? "en"
  }
}
