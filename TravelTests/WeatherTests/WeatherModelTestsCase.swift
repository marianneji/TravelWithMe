//
//  WeatherModelTestsCase.swift
//  TravelTests
//
//  Created by Graphic Influence on 18/12/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import XCTest
@testable import Travel

class WeatherModelTestsCase: XCTestCase {

    var weather: WeatherModel!

    override func setUp() {
        super.setUp()
        weather = WeatherModel(temperature: 9.55, condition: 804, cityName: "Paris", windSpeed: 4.1, tempMin: 8.89, tempMax: 10.56, humidity: 76, description: "overcast clouds", sunrise: 1572244220, sunset: 1572280697, timeZone: 3600, dt: 1572291370)
    }

    func createCondition(conditionId: Int) {
        weather.condition = conditionId
        print("""
        date de sunrise :28 Oct, 2019
        date de sunset :28 Oct, 2019
        time de sunrise :7:30:20 AM
        time de sunset :5:38:17 PM
        """)
    }

    func testWhenCallLocalSunrise() {
        let expected = weather.localSunrise()
        let result: Double = 1572247820

        let dateExpected = result.getDateStringFromUTC()
        let dateresult = "28 Oct, 2019"

        let timeExpected = result.getTimeStringFromUTC()
        let timeResult = "7:30:20 AM"

        XCTAssertEqual(expected, result)
        XCTAssertEqual(dateExpected, dateresult)
        XCTAssertEqual(timeExpected, timeResult)
    }

    func testWhenCallLocalSunset() {
        let expected = weather.localSunset()
        let result: Double = 1572284297

        XCTAssertEqual(expected, result)
    }

    func testWhenSwitchConditionNameCode804() {
        let expected = weather.conditionName
        let result = "cloudy2"

        XCTAssertEqual(expected, result)
    }

    func testWhenSwitchConditionNameCode200() {
        createCondition(conditionId: 200)
        let result = "tstorm1"

        XCTAssertEqual(weather.conditionName, result)
    }
    func testWhenSwitchConditionNameCode301() {
        createCondition(conditionId: 301)
        let result = "light_rain"

        XCTAssertEqual(weather.conditionName, result)
    }
    func testWhenSwitchConditionNameCode501() {
        createCondition(conditionId: 501)
        let result = "shower3"

        XCTAssertEqual(weather.conditionName, result)
    }
    func testWhenSwitchConditionNameCode601() {
        createCondition(conditionId: 601)
        let result = "snow4"

        XCTAssertEqual(weather.conditionName, result)
    }
    func testWhenSwitchConditionNameCode701() {
        createCondition(conditionId: 701)
        let result = "fog"

        XCTAssertEqual(weather.conditionName, result)
    }
    func testWhenSwitchConditionNameCode772() {
        createCondition(conditionId: 772)
        let result = "tstorm3"

        XCTAssertEqual(weather.conditionName, result)
    }



}
