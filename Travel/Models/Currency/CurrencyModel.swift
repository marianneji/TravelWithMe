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
    let euroRate: Double
    

    init(date: String, dollarRate: Double, euroRate: Double) {
        self.date = date
        self.dollarRate = dollarRate
        self.euroRate = 1.0 / dollarRate
    }

    func convertDolToEuro(dollarValue: String) -> String {
        var result = 0.0
        let tempString = dollarValue.convertToAmericanDouble()
        if let dolDouble = Double(tempString) {
            result = dolDouble * euroRate
        } 
        return result.doubleToStringTwoDecimal() + "€"
    }

    func convertEuroToDol(euroValue: String) -> String {
        var result = 0.0
        let tempString = euroValue.convertToAmericanDouble()
        if let euroDouble = Double(tempString) {
            result = euroDouble * dollarRate
        }
        return result.doubleToStringTwoDecimal() + "$"
    }
}


