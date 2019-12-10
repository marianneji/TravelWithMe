//
//  SupportedLanguageData.swift
//  Travel
//
//  Created by Graphic Influence on 14/11/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

// Datas we want to decode from JSON 

// MARK: - TranslationSymbols
struct SupportedLanguageData: Decodable {
    let data: LanguageData
}

// MARK: - DataClass
struct LanguageData: Decodable {
    let languages: [Language]
}

// MARK: - Language
struct Language: Decodable {
    let language, name: String
}
