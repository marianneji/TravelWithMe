//
//  TranslateManager.swift
//  Travel
//
//  Created by Graphic Influence on 05/11/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

class TranslateManager {
    //MARK: - Singleton
    static var shared = TranslateManager()

    private init() {
        print("coucou")
    }

    private var task: URLSessionDataTask?
    private var translateSession = URLSession(configuration: .default)

    init(translateSession: URLSession) {
        self.translateSession = translateSession
    }

    private let apiKey = Apikeys.valueForAPIKey(named: "googleApiKey")

    func translate(translateLanguage: String, textToTranslate: String, completion: @escaping (Bool, TranslationsDataClass?) -> Void) {
        guard let translateURL = URL(string: "https://translation.googleapis.com/language/translate/v2/?") else {
            return
        }
        var request = URLRequest(url: translateURL)
        request.httpMethod = "POST"
        let body = "key=\(apiKey)&target=\(translateLanguage)&q=\(textToTranslate)&format=text"
        request.httpBody = body.data(using: .utf8)
        task?.cancel()
        task = translateSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 || response.statusCode == 201 else {
                    completion(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(TranslateData.self, from: data) else {
                    completion(false, nil)
                    return
                }
                completion(true, responseJSON.data)
            }
        }
        task?.resume()
    }

    func getLanguages(completion: @escaping (Bool, LanguageData?) -> Void) {
        guard let languagesURL = URL(string: "https://translation.googleapis.com/language/translate/v2/languages?key=\(apiKey)&target=en") else { return }
        task?.cancel()
        task = translateSession.dataTask(with: languagesURL) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 || response.statusCode == 201 else {
                    completion(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(SupportedLanguageData.self, from: data) else {
                    completion(false, nil)
                    return
                }
                completion(true, responseJSON.data)
            }
        }
        task?.resume()
    }

//    var sourceLanguageCode: String?
//    var supportedLanguage = [TranslateModel]()
//    var textToTranslate: String?
//    var targetLanguageCode: String?
//    var languageCode = [String]()


//    func makeRequest(usingTranslateApi api: TranslateApi, urlParams: [String: String], completion: @escaping (Bool, _ results: [String: Any]?) -> Void) {
//        task?.cancel()
//        guard var components = URLComponents(string: api.getUrl()) else { return }
//        components.queryItems = [URLQueryItem]()
//
//        for (key, value) in urlParams {
//            components.queryItems?.append(URLQueryItem(name: key, value: value))
//        }
//
//        if let url = components.url {
//            var request = URLRequest(url: url)
//            request.httpMethod = api.getHttpMethod()
//            task = translateSession.dataTask(with: request) { (results, response, error) in
//                DispatchQueue.main.async {
//                    guard error == nil, let results = results else {
//                        completion(false, nil)
//                        return
//                    }
//                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 || response.statusCode == 201 else {
//                        completion(false, nil)
//                        return
//                    }
//                    do {
//                        if let resultDict = try JSONSerialization.jsonObject(with: results, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any] {
//                            completion(true, resultDict)
//                        }
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//        }
//        task?.resume()
//    }
//
//    func detectLanguage(forText text: String, completion: @escaping (_ language: String?) -> Void) {
//        let urlParams = ["key": apiKey, "q": text]
//        makeRequest(usingTranslateApi: .detectLanguage, urlParams: urlParams) { (success, results) in
//            guard let results = results else {
//                completion(nil)
//                return
//            }
//            guard let data = results["data"] as? [String: Any], let detections = data["detections"] as? [[[String: Any]]] else {
//                completion(nil)
//                return
//            }
//            var detectedLanguages = [String]()
//            for detection in detections {
//                for currentDetection in detection {
//                    if let language = currentDetection["language"] as? String {
//                        detectedLanguages.append(language)
//                    }
//                }
//            }
//            if detectedLanguages.count > 0 {
//                self.sourceLanguageCode = detectedLanguages[0]
//                completion(detectedLanguages[0])
//            } else {
//                completion(nil)
//            }
//        }
//    }
//
//    func fetchSupportedLanguage(completion: @escaping (_ success: Bool) -> Void) {
//        var urlParams = [String: String]()
//        urlParams["key"] = apiKey
//        urlParams["target"] = Locale.current.languageCode ?? "en"
//
//        makeRequest(usingTranslateApi: .supportedLanguage, urlParams: urlParams) { (success, results) in
//            guard let results = results else {
//                completion(false)
//                return
//            }
//            guard let data = results["data"] as? [String: Any], let languages = data["languages"] as? [[String: Any]] else {
//                completion(false)
//                return
//            }
//            for lang in languages {
//
//                guard let code = lang["language"] as? String, let name = lang["name"] as? String else {
//                    completion(false)
//                    return
//                }
//                self.supportedLanguage.append(TranslateModel(code: code, name: name))
//                self.languageCode.append(code)
//                completion(true)
//            }
//        }
//    }
//
//    func translate(completion: @escaping (_ translations: String?) -> Void) {
//
//        guard let textToTranslate = textToTranslate, let targetLanguage = targetLanguageCode else {
//            completion(nil)
//            return
//        }
//        var urlParams = [String: String]()
//        urlParams["key"] = apiKey
//        urlParams["q"] = textToTranslate
//        urlParams["format"] = "text"
//        urlParams["target"] = targetLanguage
//        
//        if let sourceCode = sourceLanguageCode {
//            urlParams["source"] = sourceCode
//        }
//        makeRequest(usingTranslateApi: .translate, urlParams: urlParams) { (success, results) in
//            guard let results = results else {
//                completion(nil)
//                return
//            }
//            guard let data = results["data"] as? [String: Any], let translations = data["translations"] as? [[String: Any]] else {
//                completion(nil)
//                return
//            }
//            var allTranslations = [String]()
//            for translation in translations {
//                if let translatedText = translation["translatedText"] as? String {
//                    allTranslations.append(translatedText)
//                }
//            }
//            if allTranslations.count > 0 {
//                completion(allTranslations[0])
//            }
//        }
//    }
}
