//
//  File.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import Foundation

enum DateFormat: String {
    case day  = "EEEE, MMM d"
}

extension Int {
    func dateFormat(_ type: DateFormat) -> String {
        let dateFromUnix = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue
        if LanguageManager.getAppLang().rawValue == "ru" {
            dateFormatter.locale = Locale(identifier: "ru_RU")
        }
        return dateFormatter.string(from: dateFromUnix)
    }
}
