//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Андрей Барсук on 24.05.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchWeather(from url: String, _ completion: @escaping(Result<Weather, NetworkError>) -> Void) {
//        guard let url = URL(string: url) else { return }
        
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let weatherData = value as? [String: Any] else { return }
                    guard let currentWeatherData = weatherData["current_weather"] as? [String: Any] else { return }
                    guard let dailyWeatherData = weatherData["daily"] as? [String: Any] else { return }
                    
                    let weather = Weather(
                        currentWeather: CurrentWeather(from: currentWeatherData),
                        daily: DailyWeather(from: dailyWeatherData)
                    )
                    
                    completion(.success(weather))
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
}


