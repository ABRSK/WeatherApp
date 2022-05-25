//
//  ViewController.swift
//  WeatherApp
//
//  Created by Андрей Барсук on 24.05.2022.
//

import UIKit

class ViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentWeatherView.alpha = 0
        sunriseSunsetView.alpha = 0
        futureWeatherView.alpha = 0
        
        getWeather()
    }
    
    private func getWeather() {
        networkManager.fetchWeather(for: Link.moscow.rawValue) { currentWeather, dailyWeather in
            DispatchQueue.main.async {
                self.currentWeather = currentWeather
                self.dailyWeather = dailyWeather
                self.configureUI()
            }
        }
    }
    
    private func configureUI() {
        currentTemperatureLabel.text = "\(currentWeather.temperature)°"
        weatherIconImageView.image = UIImage(named: getWeatherIcon(for: currentWeather.weathercode))
        currentWindSpeedLabel.text = "Wind speed: \(currentWeather.windspeed) Km/h"
        
        sunriseTimeLabel.text = getDateOrTime(from: dailyWeather.sunrise[0])
        sunsetTimeLabel.text = getDateOrTime(from: dailyWeather.sunset[0])
        sunriseImageView.image = UIImage(named: "sunrise")
        sunsetImageView.image = UIImage(named: "sunset")
        
        tomorrowDateLabel.text = getDateOrTime(from: dailyWeather.time[1])
        afterTomorrowDateLabel.text = getDateOrTime(from: dailyWeather.time[2])
        afterAfterTomorrowDateLabel.text = getDateOrTime(from: dailyWeather.time[3])
        
        tomorrowTemperatureLabel.text = "\(dailyWeather.temperature_2m_min[1])° / \(dailyWeather.temperature_2m_max[1])°"
        afterTomorrowTemperatureLabel.text = "\(dailyWeather.temperature_2m_min[2])° / \(dailyWeather.temperature_2m_max[2])"
        afterAfterTomorrowTemperatureLabel.text = "\(dailyWeather.temperature_2m_min[3])° / \(dailyWeather.temperature_2m_max[3])"
        
        tomorrowIconImageView.image = UIImage(named: getWeatherIcon(for: dailyWeather.weathercode[1]))
        afterTomorrowImageView.image = UIImage(named: getWeatherIcon(for: dailyWeather.weathercode[2]))
        afterAfterTomorrowImageView.image = UIImage(named: getWeatherIcon(for: dailyWeather.weathercode[3]))
        
        let uiViews = [currentWeatherView, sunriseSunsetView, futureWeatherView]
        
        for view in uiViews {
            DispatchQueue.main.async {
                view?.fadeIn()
                view?.alpha = 1
            }
        }
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
    
    private func getDateOrTime(from string: String) -> String {
        let dateOrTime = string.suffix(5)
        return String(dateOrTime)
    }
}
