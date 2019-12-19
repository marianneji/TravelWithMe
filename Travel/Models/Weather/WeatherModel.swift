//
//  WeatherDataModel.swift
//  Travel
//
//  Created by Graphic Influence on 25/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    //Declare the model variables 
    var temperature: Double
    var condition: Int
    var cityName: String
    var windSpeed: Double
    var tempMin: Double
    var tempMax: Double
    var humidity: Int
    var description: String
    var sunrise: Double
    var sunset: Double
    var timeZone: Double
    let dt: Double

    func localSunrise() -> Double {
        let returnValue = sunrise + timeZone
        return returnValue
    }
    func localSunset() -> Double {
        let returnValue = sunset + timeZone
        return returnValue
    }

    //This method turns a condition code into the name of the weather condition image
    var conditionName: String {
        
        switch condition {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000 :
            return "tstorm3"
            
        case 903 :
            return "snow5"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
    }
}
