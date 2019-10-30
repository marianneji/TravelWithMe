//
//  TravelTests.swift
//  TravelTests
//
//  Created by Graphic Influence on 28/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import XCTest
@testable import Travel

class WeatherTestsCase: XCTestCase {
//MARK: - TestGetCity
    func testGetCityshouldPostfailedCallbackIfError() {
        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: nil, response: nil, error: WeatherFakeResponseData.error))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherManager.getCity(city: "london") { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCityshouldPostfailedCallbackWhenNoData() {
        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: nil, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherManager.getCity(city: "london") { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetCityshouldPostfailedCallbackIfIncorrectResponse() {
        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: WeatherFakeResponseData.weatherCorrectData, response: WeatherFakeResponseData.responseKo, error: nil))

               let expectation = XCTestExpectation(description: "Wait for queue change.")
               weatherManager.getCity(city: "london") { (success, weather) in
                   XCTAssertFalse(success)
                   XCTAssertNil(weather)
                   expectation.fulfill()
               }
               wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCityshouldPostfailedCallbackIfIncorrectData() {
        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: WeatherFakeResponseData.weatherIncorrectData, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherManager.getCity(city: "london") { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetCityshouldPostSuccessCallbackIfDataAndNoError() {
        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: WeatherFakeResponseData.weatherCorrectData, response: WeatherFakeResponseData.responseOk, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherManager.getCity(city: "Paris") { (success, weather) in
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            XCTAssertEqual("Paris", weather?.cityName)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    //MARK: - TestGetLocation
    func testGetLocationshouldPostfailedCallbackIfError() {
        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: nil, response: nil, error: WeatherFakeResponseData.error))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherManager.getCurrentLocationWeather(latitude: 48.86, longitude: 2.35) { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetLocationshouldPostfailedCallbackWhenNoData() {
        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: nil, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherManager.getCurrentLocationWeather(latitude: 48.86, longitude: 2.35) { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetLocationshouldPostfailedCallbackIfIncorrectResponse() {
        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: WeatherFakeResponseData.weatherCorrectData, response: WeatherFakeResponseData.responseKo, error: nil))

               let expectation = XCTestExpectation(description: "Wait for queue change.")
               weatherManager.getCurrentLocationWeather(latitude: 48.86, longitude: 2.35) { (success, weather) in
                   XCTAssertFalse(success)
                   XCTAssertNil(weather)
                   expectation.fulfill()
               }
               wait(for: [expectation], timeout: 0.01)
    }

    func testGetLocationshouldPostfailedCallbackIfIncorrectData() {
        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: WeatherFakeResponseData.weatherIncorrectData, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherManager.getCurrentLocationWeather(latitude: 48.86, longitude: 2.35) { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetLocationshouldPostSuccessCallbackIfDataAndNoError() {
        let weatherManager = WeatherManager(weatherSession: URLSessionFake(data: WeatherFakeResponseData.weatherCorrectData, response: WeatherFakeResponseData.responseOk, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherManager.getCurrentLocationWeather(latitude: 48.86, longitude: 2.35) { (success, weather) in
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
