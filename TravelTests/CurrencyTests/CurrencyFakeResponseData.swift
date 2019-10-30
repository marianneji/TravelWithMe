//
//  CurrencyFakeResponseData.swift
//  TravelTests
//
//  Created by Graphic Influence on 30/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

class CurrencyFakeResponseData {

    static var currencyCorrectData: Data {
        let bundle = Bundle(for: CurrencyFakeResponseData.self)
        let url = bundle.url(forResource: "Currency", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    static let currencyIncorrectData = "erreur".data(using: .utf8)


    static let responseOk = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])

    static let responseKo = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: [:])

    class CurrencyError: Error {}
    static let error = CurrencyError()
}
