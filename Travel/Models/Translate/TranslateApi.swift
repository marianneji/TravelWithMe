//
//  TranslateDataModel.swift
//  Travel
//
//  Created by Graphic Influence on 25/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

enum TranslateApi {
    case translate
    case supportedLanguage
    case detectLanguage

    func getUrl() -> String {
        var urlString = ""
        switch self {
        case .detectLanguage:
            urlString = "https://translation.googleapis.com/language/translate/v2/detect"
        case .translate:
            urlString = "https://translation.googleapis.com/language/translate/v2"
        case .supportedLanguage:
            urlString = "https://translation.googleapis.com/language/translate/v2/languages"
        }
        return urlString
    }

    func getHttpMethod() -> String {
        if self == .supportedLanguage {
            return "GET"
        } else {
            return "POST"
        }
    }
}

