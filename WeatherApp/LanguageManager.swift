//
//  File.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import Foundation
import Localize_Swift

class LanguageManager {
    
    static func setApplLang(_ lang: Language) {
        Localize.setCurrentLanguage(lang.rawValue)
    }
    
    static func getAppLang() -> Language {
        return Language(rawValue: Localize.currentLanguage())!
    }
}


enum Language: String {
    case English = "en"
    case Russian = "ru"
    case lanDesc = "Language"
    
    static func language(for str: String) -> Language {
        if str == "en" {
            return .English
        } else if str == "ru" {
            return .Russian
        } else {
            return .lanDesc
        }
    }
}
