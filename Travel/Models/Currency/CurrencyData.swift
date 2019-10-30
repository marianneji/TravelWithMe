//
//  CurrencyDataModel.swift
//  Travel
//
//  Created by Graphic Influence on 25/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

struct CurrencyData: Codable {
    let base: String
    let date: String
    let rates: Rates
}
struct Rates: Codable {
    let USD: Double
}
