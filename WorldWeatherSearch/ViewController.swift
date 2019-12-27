//
//  ViewController.swift
//  WorldWeatherSearch
//
//  Created by Phanindra Kumar  on 23/12/19.
//  Copyright © 2019 Phanindra Kumar . All rights reserved.
//

import UIKit

protocol SelectedModelDelegate: class {
    func handleSelectedModel(selectedModel: SearchModelObject)
}

class ViewController: UIViewController {
    
    var searchController: UISearchController!
        
    var recentSearchObjects: [SearchModelObject]?
    
    let searchHistoryTitle = "Recent Search History"

    @IBOutlet weak var recentSearchesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("In view controller")
        setUpSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        
        if let searchObjects = WeatherDisplayViewController.getAllRecentSearchObjects {
            
            sortRecentSearchItemsWithLatestFirst(searchObjects)
            
        }
        
        recentSearchesTableView.reloadData()
    }
    
    func setUpSearchController() {
        
        if let resultsTableController =
                   storyboard!.instantiateViewController(withIdentifier: "SearchResultsTableController")
                   as? SearchResultsTableController {
                   
                   resultsTableController.delegate = self
                   searchController = UISearchController(searchResultsController: resultsTableController)
                   
                   searchController.searchResultsUpdater = resultsTableController as UISearchResultsUpdating
                   
               }
               
               searchController.searchBar.sizeToFit()
               searchController.searchBar.placeholder = "Search for places"
               
               navigationItem.searchController = searchController
               navigationItem.hidesSearchBarWhenScrolling = false

               searchController.hidesNavigationBarDuringPresentation = false
               searchController.dimsBackgroundDuringPresentation = true
               definesPresentationContext = true
        
    }
    
    func sortRecentSearchItemsWithLatestFirst(_ searchObjects: [SearchModelObject]) {
        
        recentSearchObjects = searchObjects.sorted(by: { $0.timeStamp! > $1.timeStamp! })

    }
    
    func displayWeatherView(for searchModel: SearchModelObject) {
        
        // swiftlint:disable force_cast
        let weatherDisplayController = storyboard!.instantiateViewController(withIdentifier: "WeatherDisplayController") as! WeatherDisplayViewController
        // swiftlint:enable force_cast
        weatherDisplayController.selectedModel = searchModel
        self.navigationController?.pushViewController(weatherDisplayController, animated: true)
    }

}

extension ViewController: SelectedModelDelegate {
    
    func handleSelectedModel(selectedModel: SearchModelObject) {
        
        displayWeatherView(for: selectedModel)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let recentSearchCell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchCell", for: indexPath as IndexPath)

        if let recentSearchObjectsArr = recentSearchObjects {
            
            let recentSearchObject = recentSearchObjectsArr[indexPath.row]
            var titleStr = ""
            if let areaName = recentSearchObject.areaName, areaName.count>0 {
                
                titleStr = areaName[0].value ?? ""
            }
            if let country = recentSearchObject.country, country.count>0 {
                titleStr.append(", ")
                titleStr.append(country[0].value ?? "")
            }
            
            recentSearchCell.textLabel?.text = titleStr
            
        } else {
            recentSearchCell.textLabel?.text = "No Recent Searches"
        }
        
        return recentSearchCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let recentSearchObjectsArr = recentSearchObjects {
            return recentSearchObjectsArr.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return searchHistoryTitle
    }
    
}

extension ViewController: UITableViewDelegate {
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       if let recentSearchObjectsArr = recentSearchObjects {
        
            let recentSearchObject = recentSearchObjectsArr[indexPath.row]
            
               displayWeatherView(for: recentSearchObject)
           
        }
    }

}
