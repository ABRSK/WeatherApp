//
//  Weather.swift
//  WeatherApp
//
//  Created by Андрей Барсук on 24.05.2022.
//

enum Link: String {
    case moscow = "https://api.open-meteo.com/v1/forecast?latitude=59.83&longitude=30.33&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset&current_weather=true&timezone=Europe%2FMoscow"
}

struct Weather: Decodable {
    let currentWeather: CurrentWeather
    let daily: DailyWeather
}

struct CurrentWeather: Decodable {
    let windspeed: Double?
    let weatherCode: Int?
    let temperature: Double?
    
    init(from currentWeatherData: [String: Any]) {
        windspeed = currentWeatherData["windspeed"] as? Double
        weatherCode = currentWeatherData["weathercode"] as? Int
        temperature = currentWeatherData["temperature"] as? Double
    }
}

struct DailyWeather: Decodable {
    let temperatureMin: [Double]?
    let sunset: [String]?
    let temperatureMax: [Double]?
    let time: [String]?
    let weatherCode: [Int]?
    let sunrise: [String]?
    
    init(from dailyWeatherData: [String: Any]) {
        temperatureMin = dailyWeatherData["temperature_2m_min"] as? [Double]
        sunset = dailyWeatherData["sunset"] as? [String]
        temperatureMax = dailyWeatherData["temperature_2m_max"] as? [Double]
        time = dailyWeatherData["time"] as? [String]
        weatherCode = dailyWeatherData["weathercode"] as? [Int]
        sunrise = dailyWeatherData["sunrise"] as? [String]
    }
}

enum WeatherIcon: Character {
    case clear = "☀️"
    case cloudy = "⛅️"
    case fog = "🌫"
    case drizzle = "🌦"
    case rain = "🌧"
    case snow = "🌨"
    case thunder = "⛈"
    case unknown = "❔"
}

//0    Clear sky
//1, 2, 3    Mainly clear, partly cloudy, and overcast
//45, 48    Fog and depositing rime fog
//51, 53, 55    Drizzle: Light, moderate, and dense intensity
//56, 57    Freezing Drizzle: Light and dense intensity
//61, 63, 65    Rain: Slight, moderate and heavy intensity
//66, 67    Freezing Rain: Light and heavy intensity
//71, 73, 75    Snow fall: Slight, moderate, and heavy intensity
//77    Snow grains
//80, 81, 82    Rain showers: Slight, moderate, and violent
//85, 86    Snow showers slight and heavy
//95 *    Thunderstorm: Slight or moderate
//96, 99 *    Thunderstorm with slight and heavy hail


