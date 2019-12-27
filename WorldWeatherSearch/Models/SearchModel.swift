//
//  SearchModelObject.swift
//  WorldWeatherSearch
//
//  Created by Phanindra Kumar  on 23/12/19.
//  Copyright © 2019 Phanindra Kumar . All rights reserved.
//

import UIKit

class SearchModel: Codable {
    
    var searchApi: SearchAPIResult?
    
    enum CodingKeys: String, CodingKey {
        case searchApi = "search_api"
    }
}

class SearchAPIResult: Codable {
    
    var result: [SearchModelObject]?
    
}

 class SearchModelObject: Codable {
    
    var areaName: [Area]?
    var country: [Country]?
    var region: [Region]?
    var latitude: String?
    var longitude: String?
    var population: String?
    var weatherUrl: [WeatherUrl]?
    var timeStamp: Int64?
    
}

class Area: Codable {
    
    var value: String?
}

class Country: Codable {
    
    var value: String?
    
}

class Region: Codable {
    
    var value: String?
    
}

class WeatherUrl: Codable {
    
    var value: String?
    
}
