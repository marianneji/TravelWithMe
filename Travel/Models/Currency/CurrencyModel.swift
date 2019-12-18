//
//  CurrencyModel.swift
//  Travel
//
//  Created by Graphic Influence on 29/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation
import UIKit

class CurrencyModel {
    
    let date: String
    var dollarRate: Double


    init(date: String, dollarRate: Double) {
        self.date = date
        self.dollarRate = dollarRate
    }

    func convertDolToEuro(dollarValue: String) -> String {
        let euroRate = 1.0 / dollarRate
        var result = 0.0
        let tempString = dollarValue.convertToAmericanDouble()
        if let dolDouble = Double(tempString) {
            result = dolDouble * euroRate
        } else {
            print("Problème dans la conversion dol euro")
        }
        return result.doubleToStringTwoDecimal() + "€"
    }
    func convertEuroToDol(euroValue: String) -> String {
        var result = 0.0
        let tempString = euroValue.convertToAmericanDouble()
        if let euroDouble = Double(tempString) {
            result = euroDouble * dollarRate
        } else {
            print("y'a un bug dans la conversion euro dol...")
        }
        return result.doubleToStringTwoDecimal() + "$"
    }

    var returnRateValue: String {
        return String(format: "%.2f", dollarRate)
    }
}


