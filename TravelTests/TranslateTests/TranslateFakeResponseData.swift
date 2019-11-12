//
//  TranslateFakeResponseData.swift
//  TravelTests
//
//  Created by Graphic Influence on 07/11/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

class TranslateFakeResponseData {

    static var translateCorrectData: Data {
        let bundle = Bundle(for: TranslateFakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    static let translateIncorrectData = "erreur".data(using: .utf8)


    static let responseOk = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])

    static let responseKo = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: [:])

    class TranslateError: Error {}
    static let error = TranslateError()
}
