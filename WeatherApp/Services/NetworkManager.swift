//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Андрей Барсук on 24.05.2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchWeather(for url: String, _ completion: @escaping(CurrentWeather, DailyWeather) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Unknown error has occurred.")
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                let currentWeather = weather.current_weather
                let dailyWeather = weather.daily
                completion(currentWeather, dailyWeather)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}

