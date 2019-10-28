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
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let main: String
    let id: Int
}


