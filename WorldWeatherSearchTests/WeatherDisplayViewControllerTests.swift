//
//  WeatherDisplayViewControllerTests.swift
//  WorldWeatherSearchTests
//
//  Created by Phanindra Kumar  on 27/12/19.
//  Copyright © 2019 Phanindra Kumar . All rights reserved.
//

import XCTest

class WeatherDisplayViewControllerTests: XCTestCase {
    
    var weatherDisplayViewController: WeatherDisplayViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle(for: WeatherDisplayViewControllerTests.self))
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherDisplayController") as? WeatherDisplayViewController
        
        weatherDisplayViewController = viewController
        
        _ = weatherDisplayViewController.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCurrentWeatherAPIHandler() {
        
        let expectation = self.expectation(description: "Display Current Weather Handler")

        let locationString = "51.517,-0.106"
        
        weatherDisplayViewController.getCurrentWeatherFromAPI(for: locationString)
        
        weatherDisplayViewController.setUpUIForCurrenWeather()
        
        expectation.fulfill()
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }

}
