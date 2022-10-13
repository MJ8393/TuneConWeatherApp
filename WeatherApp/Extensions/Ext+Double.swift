//
//  File.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import Foundation

extension Double {
    func formatTemp() -> String {
        return "\(String(format: "%.1f", self))°C"
    }
}
