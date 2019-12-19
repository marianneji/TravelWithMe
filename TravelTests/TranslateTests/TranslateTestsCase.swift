//
//  TranslateTestsCase.swift
//  TravelTests
//
//  Created by Graphic Influence on 07/11/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import XCTest
@testable import Travel

class TranslateTestsCase: XCTestCase {
//MARK: - TestTranslate
    func testTranslateshouldPostfailedCallbackIfError() {
        let translateManager = TranslateManager(translateSession: URLSessionFake(data: nil, response: nil, error: TranslateFakeResponseData.error))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateManager.translate(translateLanguage: "en", textToTranslate: "bonjour") { (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.03)
    }

    func testTranslateshouldPostfailedCallbackIfNoData() {
        let translateManager = TranslateManager(translateSession: URLSessionFake(data: nil, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateManager.translate(translateLanguage: "en", textToTranslate: "bonjour") { (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.03)
    }

    func testTranslateshouldPostfailedCallbackIfIncorrectResponse() {
        let translateManager = TranslateManager(translateSession: URLSessionFake(data: TranslateFakeResponseData.translateCorrectData, response: TranslateFakeResponseData.responseKo, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateManager.translate(translateLanguage: "en", textToTranslate: "bonjour") { (success, translation) in
            XCTAssertNil(translation)
            XCTAssertFalse(success)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.03)
    }

    func testTranslateshouldPostfailedCallbackIfIncorrectData() {
        let translateManager = TranslateManager(translateSession: URLSessionFake(data: TranslateFakeResponseData.translateIncorrectData, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateManager.translate(translateLanguage: "en", textToTranslate: "bonjour") { (success, translation) in
            XCTAssertNil(translation)
            XCTAssertFalse(success)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.03)
    }

    func testTranslateshouldPostSuccessCallbackIfDataAndNoError() {
        let translateManager = TranslateManager(translateSession: URLSessionFake(data: TranslateFakeResponseData.translateCorrectData, response: TranslateFakeResponseData.responseOk, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateManager.translate(translateLanguage: "en", textToTranslate: "Bonjour les vaches") { (success, translation) in
//            let translatedText = "Hi cows"
            XCTAssertNotNil(translation)
            XCTAssertTrue(success)
            XCTAssertEqual("Hi cows", translation?.translations[0].translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.03)
    }
    func testGetLanguagesShouldPostfailedCallbackIfError() {
            let translateManager = TranslateManager(translateSession: URLSessionFake(data: nil, response: nil, error: TranslateFakeResponseData.error))

            let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateManager.getLanguages { (success, language) in

                XCTAssertFalse(success)
                XCTAssertNil(language)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.03)
        }

        func testGetLanguagesShouldPostfailedCallbackIfNoData() {
            let translateManager = TranslateManager(translateSession: URLSessionFake(data: nil, response: nil, error: nil))

            let expectation = XCTestExpectation(description: "Wait for queue change.")
            translateManager.getLanguages { (success, language) in

                XCTAssertFalse(success)
                XCTAssertNil(language)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.03)
        }

        func testGetLanguagesShouldPostfailedCallbackIfIncorrectResponse() {
            let translateManager = TranslateManager(translateSession: URLSessionFake(data: TranslateFakeResponseData.languagesCorrectData, response: TranslateFakeResponseData.responseKo, error: nil))

            let expectation = XCTestExpectation(description: "Wait for queue change.")
            translateManager.getLanguages { (success, language) in

                XCTAssertNil(language)
                XCTAssertFalse(success)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.03)
        }

        func testGetLanguagesShouldPostfailedCallbackIfIncorrectData() {
            let translateManager = TranslateManager(translateSession: URLSessionFake(data: TranslateFakeResponseData.languagesIncorrectData, response: nil, error: nil))

            let expectation = XCTestExpectation(description: "Wait for queue change.")
            translateManager.getLanguages { (success, language) in

                XCTAssertNil(language)
                XCTAssertFalse(success)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.03)
        }

        func testGetLanguagesShouldPostSuccessCallbackIfDataAndNoError() {
            let translateManager = TranslateManager(translateSession: URLSessionFake(data: TranslateFakeResponseData.languagesCorrectData, response: TranslateFakeResponseData.responseOk, error: nil))

            let expectation = XCTestExpectation(description: "Wait for queue change.")
            translateManager.getLanguages { (success, language) in
                let languageCode = "af"
                let name = "Afrikaans"

                XCTAssertNotNil(languageCode)
                XCTAssertTrue(success)
                XCTAssertEqual(languageCode, language?.languages[0].language)
                XCTAssertEqual(name, language?.languages[0].name)
                
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.03)
        }

}
