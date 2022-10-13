//
//  File.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.openweathermap.org/data/2.5/onecall?"
    static let IP_KEY = "b06f2be68923c666bc3cfbe68d35d8a1"
    static let exclude = "minutely,hourly"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType: String {
    case json = "application/json"
}

