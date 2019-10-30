//
//  CurrencyModel.swift
//  Travel
//
//  Created by Graphic Influence on 29/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

class CurrencyModel {
    
    let baseCurrency: String
    let date: String
    var dollarRate: Double

    init(baseCurrency: String, date: String, dollarRate: Double) {
        self.baseCurrency = baseCurrency
        self.date = date
        self.dollarRate = dollarRate
    }

    var returnRateValue: String {
        return String(format: "%.2f", dollarRate)
    }
}


