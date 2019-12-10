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
    var euroRate = 1.0

    var dateFormatted: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, yyyy"

        let dateString: NSDate? = dateFormatterGet.date(from: date) as NSDate?
        guard let dString = dateString else { return "erreur"}
        print(dateFormatterPrint.string(from: dString as Date))
        return (dateFormatterPrint.string(from: dString as Date))
    }

    func convertEuroToDol(euroValue: String) -> String {
        var result = 0.0

        if let euroDouble = Double(euroValue) {
            result = euroDouble * dollarRate
        } else {
            print("y'a un bug...")
        }
        return String(format: "%.2f", result) + "$"
    }

    var returnRateValue: String {
        return String(format: "%.2f", dollarRate)
    }
}


