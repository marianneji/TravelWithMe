//
//  CurrentModelTestsCase.swift
//  TravelTests
//
//  Created by Graphic Influence on 18/12/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import XCTest
@testable import Travel

class CurrencyModelTestsCase: XCTestCase {

    var currency: CurrencyModel!

    override func setUp() {
        super.setUp()
        currency = CurrencyModel(date: "2019-10-28", dollarRate: 1.109914, euroRate: 0.0 )
    }

    func testWhenCallConvertDolToEuro() {
        let expected = currency.convertDolToEuro(dollarValue: "1")
        let result = "0.90€"

        XCTAssertEqual(expected, result)
    }

    func testWhenCallConvertEuroToDol() {
        let expected = currency.convertEuroToDol(euroValue: "1")
        let result = "1.11$"

        XCTAssertEqual(expected, result)
    }

}
