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
        translateManager.translate { (success) in
            XCTAssertNil(success)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testTranslateshouldPostfailedCallbackIfNoData() {
        let translateManager = TranslateManager(translateSession: URLSessionFake(data: nil, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateManager.translate { (success) in
            XCTAssertNil(success)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testTranslateshouldPostfailedCallbackIfIncorrectResponse() {
        let translateManager = TranslateManager(translateSession: URLSessionFake(data: TranslateFakeResponseData.translateCorrectData, response: TranslateFakeResponseData.responseKo, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateManager.translate { (success) in
            XCTAssertNil(success)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testTranslateshouldPostfailedCallbackIfIncorrectData() {
        let translateManager = TranslateManager(translateSession: URLSessionFake(data: TranslateFakeResponseData.translateIncorrectData, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateManager.translate { (success) in
            XCTAssertNil(success)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testTranslateshouldPostSuccessCallbackIfDataAndNoError() {
        let translateManager = TranslateManager(translateSession: URLSessionFake(data: TranslateFakeResponseData.translateCorrectData, response: TranslateFakeResponseData.responseOk, error: nil))
        let urlParams = [String: String]()
//        urlParams["key"] = apiKey
//        urlParams["q"] = "bonjour les vaches"
//        urlParams["format"] = "text"
//        urlParams["target"] = "en"
        

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateManager.makeRequest(usingTranslateApi: .translate, urlParams: urlParams) { (results) in
            XCTAssertNotNil(results)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
//    func testGetCityshouldPostSuccessCallbackIfDataAndNoError() {
//        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: WeatherFakeResponseData.weatherCorrectData, response: WeatherFakeResponseData.responseOk, error: nil))
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherManager.getCity(city: "Paris") { (success, weather) in
//            XCTAssertTrue(success)
//            XCTAssertNotNil(weather)
//            XCTAssertEqual("Paris", weather?.cityName)
//
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//    //MARK: - TestGetLocation
//    func testGetLocationshouldPostfailedCallbackIfError() {
//        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: nil, response: nil, error: WeatherFakeResponseData.error))
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherManager.getCurrentLocationWeather(latitude: 48.86, longitude: 2.35) { (success, weather) in
//            XCTAssertFalse(success)
//            XCTAssertNil(weather)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetLocationshouldPostfailedCallbackWhenNoData() {
//        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherManager.getCurrentLocationWeather(latitude: 48.86, longitude: 2.35) { (success, weather) in
//            XCTAssertFalse(success)
//            XCTAssertNil(weather)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//    func testGetLocationshouldPostfailedCallbackIfIncorrectResponse() {
//        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: WeatherFakeResponseData.weatherCorrectData, response: WeatherFakeResponseData.responseKo, error: nil))
//
//               let expectation = XCTestExpectation(description: "Wait for queue change.")
//               weatherManager.getCurrentLocationWeather(latitude: 48.86, longitude: 2.35) { (success, weather) in
//                   XCTAssertFalse(success)
//                   XCTAssertNil(weather)
//                   expectation.fulfill()
//               }
//               wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetLocationshouldPostfailedCallbackIfIncorrectData() {
//        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: WeatherFakeResponseData.weatherIncorrectData, response: nil, error: nil))
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherManager.getCurrentLocationWeather(latitude: 48.86, longitude: 2.35) { (success, weather) in
//            XCTAssertFalse(success)
//            XCTAssertNil(weather)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//    func testGetLocationshouldPostSuccessCallbackIfDataAndNoError() {
//        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: WeatherFakeResponseData.weatherCorrectData, response: WeatherFakeResponseData.responseOk, error: nil))
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherManager.getCurrentLocationWeather(latitude: 48.86, longitude: 2.35) { (success, weather) in
//            XCTAssertTrue(success)
//            XCTAssertNotNil(weather)
//
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }

}
