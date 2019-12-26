//
//  SearchResultsTableController.swift
//  WorldWeatherSearch
//
//  Created by Phanindra Kumar  on 23/12/19.
//  Copyright © 2019 Phanindra Kumar . All rights reserved.
//

import UIKit

class SearchResultsTableController: UITableViewController {
    
    var searchModel: SearchModel?
    
    var delegate: SelectedModelDelegate?
    
    var matchingItems: [SearchModelObject]? {
        didSet {
           DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var weatherServiceHandler: WeatherServiceAPIHandler!
    
    let searchURLString = "https://api.worldweatheronline.com/premium/v1/search.ashx"

    override func viewDidLoad() {
          super.viewDidLoad()
        weatherServiceHandler = WeatherServiceAPIHandler()
        
    }
    
    func getSearchResultsFromAPI(with searchStr: String) {
        
        let successHandler: (SearchModel) -> Void = { (searchModel) in
            self.matchingItems = searchModel.search_api?.result
        }
        
        let errorHandler: (String) -> Void = { (error) in
            print(error)
           // self.view?.displayError(error: error)

            self.matchingItems = nil
        }
        

        
        var parameters = [String: String]()
        
        parameters["q"] = searchStr
        parameters["key"] = WeatherServiceAPIHandler.apiKey
        parameters["format"] = "json"

        weatherServiceHandler.get(urlString: searchURLString,
                                  params: parameters,
                         successHandler: successHandler,
                         errorHandler: errorHandler)
    }
    
}

extension SearchResultsTableController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
    
        guard let searchBarText = searchController.searchBar.text else { return  }
        
        getSearchResultsFromAPI(with: searchBarText)
        
        
    }
    
}

// MARK: UITableView Datasource
extension SearchResultsTableController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let matchingResults = matchingItems {
            return matchingResults.count
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let searchResultsCell = tableView.dequeueReusableCell(withIdentifier: "SearchResultsCell", for: indexPath)
        
        if let matchingResults = matchingItems {
            
           
            
            let searchResultModelObj = matchingResults[indexPath.row]
            
            if let areaArr = searchResultModelObj.areaName, areaArr.count > 0 {
                searchResultsCell.textLabel?.text = areaArr[0].value

            }
            
            if let countryArr = searchResultModelObj.country, countryArr.count > 0 {
                searchResultsCell.detailTextLabel?.text = countryArr[0].value

            }
                            
            
        } else {
            
            
            searchResultsCell.textLabel?.text = "Results Not Found"
            searchResultsCell.detailTextLabel?.text = ""
            
        }
        
        return searchResultsCell

                
    }
    
}

extension SearchResultsTableController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let matchingResults = matchingItems {
        
            let selectedResultModel = matchingResults[indexPath.row]
            
            delegate?.handleSelectedModel(selectedModel: selectedResultModel)
            
            dismiss(animated: true, completion: nil)
        }
    }

}
