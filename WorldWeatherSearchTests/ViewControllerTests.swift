//
//  ViewControllerTests.swift
//  WorldWeatherSearchTests
//
//  Created by Phanindra Kumar  on 26/12/19.
//  Copyright © 2019 Phanindra Kumar . All rights reserved.
//

import XCTest
@testable import WorldWeatherSearch

class ViewControllerTests: XCTestCase {
    
    var homeViewController: ViewController!

    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.

        //get the storyboard the ViewController under test is inside
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle(for: ViewControllerTests.self))
        
       let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? ViewController
        
       homeViewController = viewController
        
        let _ = homeViewController.view
        
    }

    override func tearDown() {
        
        super.tearDown()

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
    
    func testViewControllerHasSearchBar() {
        
        XCTAssertNotNil(homeViewController.searchController.searchBar)
        
    }
    
    func testViewControllerHasSearchResultsViewController() {
        
          let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle(for: ViewControllerTests.self))
        
        let searchResultsVC = storyboard.instantiateViewController(withIdentifier: "SearchResultsTableController") as! SearchResultsTableController

        XCTAssertNotNil(searchResultsVC)
    }
    
    func testViewControllerHasARecentHistoryTableView() {
        XCTAssertNotNil(homeViewController.recentSearchesTableView)
    }
    
    func testRecentHistoryTableViewHasDelegate() {
        XCTAssertNotNil(homeViewController.recentSearchesTableView.delegate)
    }
    
    func testRecentHistoryTableViewConfromsToDelegateProtocol() {
        XCTAssertTrue(homeViewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(homeViewController.responds(to: #selector(homeViewController.tableView(_:didSelectRowAt:))))
    }
    
    func testRecentHistoryTableViewHasDataSource() {
        XCTAssertNotNil(homeViewController.recentSearchesTableView.dataSource)
    }
    
    func testRecentHistoryTableViewConfromsToDataSourceProtocol() {
        XCTAssertTrue(homeViewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(homeViewController.responds(to: #selector(homeViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(homeViewController.responds(to: #selector(homeViewController.tableView(_:cellForRowAt:))))
    }

    func testTableViewCellHasReuseIdentifier() {
        let cell = homeViewController.tableView(homeViewController.recentSearchesTableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let actualReuseIdentifer = cell.reuseIdentifier
        let expectedReuseIdentifier = "RecentSearchCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    func testViewControllerForSortedRecentSearches() {
        
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
        
        let searchObjectsArr = [searchObject1,searchObject2]
        
        homeViewController.sortRecentSearchItemsWithLatestFirst(searchObjectsArr)
        
        let expectedRecentSearcheTitles = ["Paris", "London"]
        if let actualRecentSearchesArr = homeViewController.recentSearchObjects {
            
           let actualSearchObject1 = actualRecentSearchesArr[0]
           let actualSearchObject2 = actualRecentSearchesArr[1]
            
            let areaTitle1 = actualSearchObject1.areaName![0].value
            let areaTitle2 = actualSearchObject2.areaName![0].value
            
            let actualRecentSearcheTitles = [areaTitle1, areaTitle2]
            
            XCTAssertEqual(actualRecentSearcheTitles, expectedRecentSearcheTitles)


        }
        
    }

}
