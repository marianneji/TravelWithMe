//
//  Extensions.swift
//  Travel
//
//  Created by Graphic Influence on 11/12/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

extension Double {

    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.timeZone = .autoupdatingCurrent
        print(dateFormatter.string(from: date))
        return dateFormatter.string(from: date)
    }
}
