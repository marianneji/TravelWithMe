//
//  CurrentWeatherModel.swift
//  Travel
//
//  Created by Graphic Influence on 04/11/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

struct CurrentWeatherModel {

    var currentTemp: Double
    var currentCity: String
    var currentConditions: Int

    var tempString: String {
        return String(format: "%.1f", currentTemp)
    }

    var conditionName: String {

        switch currentConditions {

        case 0...300 : return "tstorm1"

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

        case 900...903, 905...1000  :
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
