//
//  SupportedLanguageData.swift
//  Travel
//
//  Created by Graphic Influence on 14/11/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

// Datas we want to decode from JSON (here the languages list avilables from FR), we have to respect JSON Structure

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
