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
    let current_weather: CurrentWeather
    let daily: DailyWeather
}

struct CurrentWeather: Decodable {
    let windspeed: Float
    let weathercode: Int
    let temperature: Float
}

struct DailyWeather: Decodable {
    let temperature_2m_min: [Float]
    let sunset: [String]
    let temperature_2m_max: [Float]
    let time: [String]
    let weathercode: [Int]
    let sunrise: [String]
    
    // date - weatherCodeIcon - minTemp - maxTemp
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

