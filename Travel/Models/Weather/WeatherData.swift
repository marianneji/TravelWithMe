//
//  WeatherData.swift
//  Travel
//
//  Created by Graphic Influence on 28/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let sys: Sys
    
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Codable {
    let description: String
    let main: String
    let id: Int
}

struct Wind: Codable {
    let speed: Double
}

struct Sys: Codable {
    let sunrise : Double
    let sunset: Double
}


