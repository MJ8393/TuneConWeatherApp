//
//  File.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import Foundation
import CoreLocation

class WeatherViewModel {
    
    var weatherDataDidChange: (() -> Void)?
    var loadingDidChange: (() -> Void)?
    
    var location: CLLocation?
    var weatherData: WeatherData? {
        didSet {
            weatherDataDidChange?()
        }
    }
    var isLoading: Bool? {
        didSet {
            loadingDidChange?()
        }
    }
    
    func getWeatherData(location: CLLocation, lang: String) {
        self.location = location
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        isLoading = true
        NetworkManager.getWeatherData(lat: lat, lon: lon, lang: lang) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let weatherData):
                self.weatherData = weatherData
            case.failure(let error):
                print(error)
            }
        }
    }
    
}
