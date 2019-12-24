//
//  ViewController.swift
//  WorldWeatherSearch
//
//  Created by Phanindra Kumar  on 23/12/19.
//  Copyright © 2019 Phanindra Kumar . All rights reserved.
//

import UIKit

protocol SelectedModelDelegate {
    func handleSelectedModel(selectedModel: SearchModelObject)
}

class ViewController: UIViewController {
    
    var searchController:UISearchController!
    
    var selectedSearchModel: SearchModelObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("In view controller")
        
        let searchResultsTableController = storyboard!.instantiateViewController(withIdentifier: "SearchResultsTableController") as! SearchResultsTableController
        searchResultsTableController.delegate = self
        searchController = UISearchController(searchResultsController: searchResultsTableController)
        searchController.searchResultsUpdater = searchResultsTableController as UISearchResultsUpdating
        
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Search for places"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
    }


}

extension ViewController: SelectedModelDelegate {
    
    func handleSelectedModel(selectedModel: SearchModelObject) {
        selectedSearchModel = selectedModel
        
        let weatherDisplayController = storyboard!.instantiateViewController(withIdentifier: "WeatherDisplayController") as! WeatherDisplayViewController
        weatherDisplayController.selectedModel = selectedSearchModel
        self.navigationController?.pushViewController(weatherDisplayController, animated: true)
        
    }
}

