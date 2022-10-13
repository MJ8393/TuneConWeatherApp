//
//  File.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import Foundation

struct WeatherData: Codable {
    let current: CurrectWeather
    let daily: [DailyWeather]
}

struct CurrectWeather: Codable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
}

struct DailyWeather: Codable {
    let dt: Int
    let temp: Temperature
    let weather: [Weather]
}

struct Temperature: Codable {
    let day: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}
