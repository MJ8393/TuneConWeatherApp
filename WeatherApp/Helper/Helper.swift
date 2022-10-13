//
//  File.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import UIKit

class Helper {
    static func getConditionImage(weatherId: Int) -> UIImage {
        var nameIcon = "cloud"
        switch weatherId {
        case 200...232:
            nameIcon = "cloud.bolt"
        case 300...321:
            nameIcon = "cloud.drizzle"
        case 500...531:
            nameIcon = "cloud.rain"
        case 600...622:
            nameIcon = "cloud.snow"
        case 701...781:
            nameIcon = "cloud.fog"
        case 800:
            nameIcon = "sun.max"
        case 801...804:
            nameIcon = "cloud.bolt"
        default:
            nameIcon = "cloud"
        }
        return UIImage(systemName: nameIcon) ?? UIImage()
    }
}
