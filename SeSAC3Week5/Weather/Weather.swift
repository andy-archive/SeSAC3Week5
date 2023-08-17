//
//  Weather.swift
//  SeSAC3Week5
//
//  Created by Taekwon Lee on 2023/08/17.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    let wind: Wind
    let name: String
    let visibility: Int
    let weather: [Weather]
    let dt: Int
    let base: String
    let clouds: Clouds
    let coord: Coord
    let sys: Sys
    let id, cod, timezone: Int
    let main: Main
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - Main
struct Main: Codable {
    let tempMax: Double
    let humidity, pressure: Int
    let temp, tempMin, feelsLike: Double

    enum CodingKeys: String, CodingKey {
        case tempMax = "temp_max"
        case humidity, pressure, temp
        case tempMin = "temp_min"
        case feelsLike = "feels_like"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let sunset, id: Int
    let country: String
    let sunrise, type: Int
}

// MARK: - Weather
struct Weather: Codable {
    let description, icon: String
    let id: Int
    let main: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}
