//
//  CurrencyTestsCase.swift
//  TravelTests
//
//  Created by Graphic Influence on 30/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import XCTest
@testable import Travel

class CurrencyTestsCase: XCTestCase {

    func testGetCurrencyshouldPostfailedCallbackIfError() {
        let currencyManager = CurrencyManager(currencySession: URLSessionFake(data: nil, response: nil, error: CurrencyFakeResponseData.error))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyManager.getCurrencyExchangeRate(callback: { (success, currency) in
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyshouldPostfailedCallbackWhenNoData() {
        let currencyManager = CurrencyManager(currencySession: URLSessionFake(data: nil, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyManager.getCurrencyExchangeRate { (success, currency) in
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyshouldPostfailedCallbackIfIncorrectResponse() {
        let currencyManager = CurrencyManager(currencySession: URLSessionFake(data: CurrencyFakeResponseData.currencyCorrectData, response: CurrencyFakeResponseData.responseKo, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyManager.getCurrencyExchangeRate { (success, currency) in
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
      func testGetCurrencyshouldPostfailedCallbackIfIncorrectData() {
          let currencyManager = CurrencyManager(currencySession: URLSessionFake(data: CurrencyFakeResponseData.currencyIncorrectData, response: nil, error: nil))

          let expectation = XCTestExpectation(description: "Wait for queue change.")
          currencyManager.getCurrencyExchangeRate { (success, currency) in
              XCTAssertFalse(success)
              XCTAssertNil(currency)
              expectation.fulfill()
          }
          wait(for: [expectation], timeout: 0.01)
      }

    func testGetCityshouldPostSuccessCallbackIfDataAndNoError() {
        let currencyManager = CurrencyManager(currencySession: URLSessionFake(data: CurrencyFakeResponseData.currencyCorrectData, response: CurrencyFakeResponseData.responseOk, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyManager.getCurrencyExchangeRate { (success, currency) in
            XCTAssertTrue(success)
            XCTAssertNotNil(currency)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
