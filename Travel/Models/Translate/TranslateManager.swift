//
//  TranslateManager.swift
//  Travel
//
//  Created by Graphic Influence on 05/11/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

class TranslateManager {

    static let shared = TranslateManager()
    private init() {}

    private var task: URLSessionDataTask?
    private var translateSession = URLSession(configuration: .default)

    init(translateSession: URLSession) {
        self.translateSession = translateSession
    }

    private let apiKey = Apikeys.valueForAPIKey(named: "googleApiKey")

    var sourceLanguageCode: String?
    var supportedLanguage = [TranslateModel]()
    var textToTranslate: String?
    var targetLanguageCode: String?

    private func makeRequest( usingTranslateApi api: TranslateApi, urlParams: [String: String], completion: @escaping (_ results: [String: Any]?) -> Void) {
        task?.cancel()
        guard var components = URLComponents(string: api.getUrl()) else { return }
        components.queryItems = [URLQueryItem]()

        for (key, value) in urlParams {
            components.queryItems?.append(URLQueryItem(name: key, value: value))
        }

        if let url = components.url {
            var request = URLRequest(url: url)
            request.httpMethod = api.getHttpMethod()
            task = translateSession.dataTask(with: request) { (results, response, error) in
                DispatchQueue.main.async {
                    guard error == nil, let results = results else {
                        completion(nil)
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 || response.statusCode == 201 else {
                        completion(nil)
                        return
                    }
                    do {
                        if let resultDict = try JSONSerialization.jsonObject(with: results, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any] {
                            completion(resultDict)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        task?.resume()
    }

    func detectLanguage(forText text: String, completion: @escaping (_ language: String?) -> Void) {
        let urlParams = ["key": apiKey, "q": text]
        makeRequest(usingTranslateApi: .detectLanguage, urlParams: urlParams) { (results) in
            guard let results = results else {
                completion(nil)
                return
            }
            guard let data = results["data"] as? [String: Any], let detections = data["detections"] as? [[[String: Any]]] else {
                completion(nil)
                return
            }
            var detectedLanguages = [String]()
            for detection in detections {
                for currentDetection in detection {
                    if let language = currentDetection["language"] as? String {
                        detectedLanguages.append(language)
                    }
                }
            }
            if detectedLanguages.count > 0 {
                self.sourceLanguageCode = detectedLanguages[0]
                completion(detectedLanguages[0])
            } else {
                completion(nil)
            }
        }
    }

    func fetchSupportedLanguage(completion: @escaping (_ success: Bool) -> Void) {
        var urlParams = [String: String]()
        urlParams["key"] = apiKey
        urlParams["target"] = Locale.current.languageCode ?? "en"

        makeRequest(usingTranslateApi: .supportedLanguage, urlParams: urlParams) { (results) in
            guard let results = results else {
                completion(false)
                return
            }
            guard let data = results["data"] as? [String: Any], let languages = data["languages"] as? [[String: Any]] else {
                completion(false)
                return
            }
            for lang in languages {

                guard let code = lang["language"] as? String, let name = lang["name"] as? String else {
                    completion(false)
                    return
                }
                self.supportedLanguage.append(TranslateModel(code: code, name: name))
                completion(true)
            }
        }
    }

    func translate(completion: @escaping (_ translations: String?) -> Void) {

        guard let textToTranslate = textToTranslate, let targetLanguage = targetLanguageCode else {
            completion(nil)
            return
        }
        var urlParams = [String: String]()
        urlParams["key"] = apiKey
        urlParams["q"] = textToTranslate
        urlParams["format"] = "text"
        urlParams["target"] = targetLanguage

        if let sourceCode = sourceLanguageCode {
            urlParams["source"] = sourceCode
        }
        makeRequest(usingTranslateApi: .translate, urlParams: urlParams) { (results) in
            guard let results = results else {
                completion(nil)
                return
            }
            guard let data = results["data"] as? [String: Any], let translations = data["translations"] as? [[String: Any]] else {
                completion(nil)
                return
            }
            var allTranslations = [String]()
            for translation in translations {
                if let translatedText = translation["translatedtext"] as? String {
                    allTranslations.append(translatedText)
                }
            }
            if allTranslations.count > 0 {
                completion(allTranslations[0])
            }
        }
    }
}
