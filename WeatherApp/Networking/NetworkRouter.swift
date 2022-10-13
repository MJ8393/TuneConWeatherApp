//
//  NetworkRouter.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import Alamofire
import CoreLocation

enum NetworkRouter: URLRequestConvertible {
    
    case getWeatherData(lat: CLLocationDegrees, lon: CLLocationDegrees, lang: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .getWeatherData:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getWeatherData(let lat, let lon, let lang):
            return "exclude=\(Constants.exclude)&lat=\(lat)&lon=\(lon)&appid=\(Constants.IP_KEY)&units=metric&lang=\(lang)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getWeatherData:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = Constants.baseURL + path
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}

