//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Андрей Барсук on 25.05.2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet var currentWeatherView: UIView!
    @IBOutlet var sunriseSunsetView: UIView!
    @IBOutlet var futureWeatherView: UIView!
    
    @IBOutlet var currentTemperatureLabel: UILabel!
    @IBOutlet var weatherIconImageView: UIImageView!
    @IBOutlet var currentWindSpeedLabel: UILabel!
    
    @IBOutlet var sunriseImageView: UIImageView!
    @IBOutlet var sunsetImageView: UIImageView!
    
    @IBOutlet var sunriseTimeLabel: UILabel!
    @IBOutlet var sunsetTimeLabel: UILabel!
    
    @IBOutlet var tomorrowDateLabel: UILabel!
    @IBOutlet var afterTomorrowDateLabel: UILabel!
    @IBOutlet var afterAfterTomorrowDateLabel: UILabel!
    
    @IBOutlet var tomorrowTemperatureLabel: UILabel!
    @IBOutlet var afterTomorrowTemperatureLabel: UILabel!
    @IBOutlet var afterAfterTomorrowTemperatureLabel: UILabel!
    
    @IBOutlet var tomorrowIconImageView: UIImageView!
    @IBOutlet var afterTomorrowImageView: UIImageView!
    @IBOutlet var afterAfterTomorrowImageView: UIImageView!
    
    private var currentWeather: CurrentWeather!
    private var dailyWeather: DailyWeather!
    private let networkManager = NetworkManager.shared
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentWeatherView.alpha = 0
        sunriseSunsetView.alpha = 0
        futureWeatherView.alpha = 0
        loadingIndicator.hidesWhenStopped = true
        getWeather()
    }
}

extension WeatherViewController {
    private func getWeather() {
        networkManager.fetchWeather(from: Link.moscow.rawValue) { result in
            switch result {
            case .success(let weather):
                self.currentWeather = weather.currentWeather
                self.dailyWeather = weather.daily
                self.configureUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureUI() {
        currentTemperatureLabel.text = "\(currentWeather.temperature ?? 0)°"
        weatherIconImageView.image = UIImage(named: getWeatherIcon(for: currentWeather.weatherCode ?? 0))
        currentWindSpeedLabel.text = "Wind speed: \(currentWeather.windspeed ?? 0) Km/h"
        
        sunriseTimeLabel.text = getLastFive(from: dailyWeather.sunrise?[0] ?? "00:00")
        sunsetTimeLabel.text = getLastFive(from: dailyWeather.sunset?[0] ?? "00:00")
        sunriseImageView.image = UIImage(named: "sunrise")
        sunsetImageView.image = UIImage(named: "sunset")
        
        tomorrowDateLabel.text = getLastFive(from: dailyWeather.time?[1] ?? "01-01")
        afterTomorrowDateLabel.text = getLastFive(from: dailyWeather.time?[2] ?? "01-01")
        afterAfterTomorrowDateLabel.text = getLastFive(from: dailyWeather.time?[3] ?? "01-01")
        
        tomorrowTemperatureLabel.text = "\(dailyWeather.temperatureMin?[1] ?? 0)° / \(dailyWeather.temperatureMax?[1] ?? 0)°"
        afterTomorrowTemperatureLabel.text = "\(dailyWeather.temperatureMin?[2] ?? 0)° / \(dailyWeather.temperatureMax?[2] ?? 0)"
        afterAfterTomorrowTemperatureLabel.text = "\(dailyWeather.temperatureMin?[3] ?? 0)° / \(dailyWeather.temperatureMax?[3] ?? 0)"
        
        tomorrowIconImageView.image = UIImage(named: getWeatherIcon(for: dailyWeather.weatherCode?[1] ?? 0))
        afterTomorrowImageView.image = UIImage(named: getWeatherIcon(for: dailyWeather.weatherCode?[2] ?? 0))
        afterAfterTomorrowImageView.image = UIImage(named: getWeatherIcon(for: dailyWeather.weatherCode?[3] ?? 0))
        
        let uiViews = [currentWeatherView, sunriseSunsetView, futureWeatherView]
        
        for view in uiViews {
            DispatchQueue.main.async {
                view?.fadeIn()
                view?.alpha = 1
            }
        }
        
        loadingIndicator.stopAnimating()
        
    }
    
    private func getWeatherIcon(for weatherCode: Int) -> String {
        var nameOfIcon: String
        
        switch weatherCode {
        case 1, 2, 3:
            nameOfIcon = "cloudy"
        case 45, 48:
            nameOfIcon = "fog"
        case 51, 53, 55, 56, 57:
            nameOfIcon = "drizzle"
        case 61, 63, 65, 66, 67:
            nameOfIcon = "rain"
        case 71, 73, 75, 77, 85, 86:
            nameOfIcon = "snow"
        case 80, 81, 82:
            nameOfIcon = "shower"
        case 95, 96, 99:
            nameOfIcon = "thunder"
        default:
            nameOfIcon = "clear"
        }
        
        return nameOfIcon
    }
    
    private func getLastFive(from string: String) -> String {
        let lastFive = string.suffix(5)
        return String(lastFive)
    }
}

