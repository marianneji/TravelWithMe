//
//  TranslateData.swift
//  Travel
//
//  Created by Graphic Influence on 14/11/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

struct TranslateData: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
    let translatedText: String
    let detectedSourceLanguage: String
}
