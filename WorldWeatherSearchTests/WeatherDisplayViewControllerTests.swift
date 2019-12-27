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
    
    func testIfSearchObjectSavesToUserDefaults() {
        
        let searchObject1 = SearchModelObject()
        let area1 = Area()
        area1.value = "London"
        searchObject1.areaName = [area1]
        searchObject1.timeStamp = Date().currentTimeMillis()
        
        let searchObject2 = SearchModelObject()
        let area2 = Area()
        area2.value = "Paris"
        searchObject2.areaName = [area2]
        searchObject2.timeStamp = Date().currentTimeMillis() + 2
        
        let searchObjectsArr = [searchObject1, searchObject2]
        
        weatherDisplayViewController.saveAllSearchObjects(searchObjects: searchObjectsArr)
        
        let expectedSavedObjectTitles = ["London", "Paris"]
        
        if let actualSavedObjectArr = WeatherDisplayViewController.getAllRecentSearchObjects {
            
            let actualSavedObject1 = actualSavedObjectArr[0]
            let actualSavedObject2 = actualSavedObjectArr[1]
            
            let areaTitle1 = actualSavedObject1.areaName![0].value
            let areaTitle2 = actualSavedObject2.areaName![0].value
            
            let actualSavedObjectTitles = [areaTitle1, areaTitle2]
            
            XCTAssertEqual(actualSavedObjectTitles, expectedSavedObjectTitles)
        }
        
        UserDefaults.standard.removeObject(forKey: WeatherDisplayViewController.searchObjectsKey)
    }

}
