//
//  CurrencyManager.swift
//  Travel
//
//  Created by Graphic Influence on 29/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation



class CurrencyManager {
    static var shared = CurrencyManager()
    private init() {}
    private let apiKey = Apikeys.valueForAPIKey(named: "fixerApiKey")

    private static let currencyUrl = "http://data.fixer.io/api/latest?"
    private let symbol = "&symbols=USD"

    private var task: URLSessionDataTask?

    private var currencySession = URLSession(configuration: .default)

    init(currencySession: URLSession) {
        self.currencySession = currencySession
    }

    func getCurrencyExchangeRate(callback: @escaping (Bool, CurrencyModel?) -> Void) {
        let urlString = "\(CurrencyManager.currencyUrl)\(apiKey)\(symbol)"
        task?.cancel()
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)

            task = currencySession.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        callback(false, nil)
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                    }
                    guard let responseJson = try? JSONDecoder().decode(CurrencyData.self, from: data) else {
                        callback(false, nil)
                        return
                    }
                            let date = responseJson.date
                            let dollarRate = responseJson.rates.USD
                    print(dollarRate)

                    let exchangeRate = CurrencyModel(date: date, dollarRate: dollarRate, euroRate: 0.0)
                        callback(true, exchangeRate)
                }
            }
        }
        task?.resume()
    }
}
