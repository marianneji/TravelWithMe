//
//  Extensions.swift
//  Travel
//
//  Created by Graphic Influence on 11/12/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation
import UIKit

extension Double {

    func getTimeStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        print(dateFormatter.string(from: date))
        return dateFormatter.string(from: date)
    }
        func getDateStringFromUTC() -> String {
            let date = Date(timeIntervalSince1970: self)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
//            dateFormatter.timeStyle = .medium
            dateFormatter.dateFormat = "dd MMM, yyyy"
            dateFormatter.timeZone = .autoupdatingCurrent

            print(dateFormatter.string(from: date))
            return dateFormatter.string(from: date)
        }

    func doubleToStringOneDecimal() -> String {
        return String(format: "%.1f", self)
    }

    func doubleToStringTwoDecimal() -> String {
        return String(format: "%.2f", self)
    }

}

extension String {

    func convertToAmericanDouble() -> String {
        var numberOfComa = 0
        var stringResult = ""
        for letter in self {
            guard numberOfComa < 2 else {
                
                return self.replacingOccurrences(of: ".", with: "")
            }
            if letter == "," {
                numberOfComa += 1
                stringResult += "."
            } else {
                stringResult += String(letter)
            }
        }
        return stringResult
    }
    func dateFormatted() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, yyyy"

        let dateString: NSDate? = dateFormatterGet.date(from: self) as NSDate?
        guard let dString = dateString else { return "erreur"}
        print(dateFormatterPrint.string(from: dString as Date))
        return (dateFormatterPrint.string(from: dString as Date))
    }
}
//
//extension UIViewController {
//    func didFailWithError(message: String) {
//        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
//        self.present(ac, animated: true)
//    }
//}
