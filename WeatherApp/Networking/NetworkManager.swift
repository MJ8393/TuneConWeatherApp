//
//  File.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import Alamofire
import CoreLocation

class NetworkManager {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route: NetworkRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route).responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
            completion(response.result)
        }
    }
    
    static func getWeatherData(lat: CLLocationDegrees, lon: CLLocationDegrees, lang: String, completion: @escaping (Result<WeatherData, AFError>)->Void) {
        performRequest(route: NetworkRouter.getWeatherData(lat: lat, lon: lon, lang: lang), completion: completion)
    }
}
