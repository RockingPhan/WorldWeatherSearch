//
//  SearchResultsTableControllerTests.swift
//  WorldWeatherSearchTests
//
//  Created by Phanindra Kumar  on 26/12/19.
//  Copyright © 2019 Phanindra Kumar . All rights reserved.
//

import XCTest

class SearchResultsTableControllerTests: XCTestCase {
    
    var searchResultsTableController: SearchResultsTableController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle(for: SearchResultsTableControllerTests.self))
         
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchResultsTableController") as? SearchResultsTableController
         
        searchResultsTableController = viewController
        
        _ = searchResultsTableController.view
        
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
    
    func testWeatherSearchAPIHandler() {
        
        let expectation = self.expectation(description: "Weather Search Handler")
        
        let searchString = "London"
        
        searchResultsTableController.getSearchResultsFromAPI(with: searchString)
        
        if let searchResults = searchResultsTableController.matchingItems {
            print("search Results \(searchResults)")
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }

}
