//
//  Protocols.swift
//  Travel
//
//  Created by Graphic Influence on 17/12/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
}

protocol CurrencyManagerDelegate {
    func didUpdateCurrencyRates(_ currencyManager: CurrencyManager, currency: CurrencyModel)
}

