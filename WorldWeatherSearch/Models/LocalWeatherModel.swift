//
//  LocalWeatherModel.swift
//  WorldWeatherSearch
//
//  Created by Phanindra Kumar  on 24/12/19.
//  Copyright © 2019 Phanindra Kumar . All rights reserved.
//

import UIKit

class LocalWeatherModel: Codable {
    
    var data: DataResult?
    
}

class DataResult: Codable {
    
    var request: [Request]?
    var current_condition: [CurrentCondition]?
    var weather: [Weather]?
    var ClimateAverages: [ClimateAvgs]

    
}

 class Request: Codable {
    
    var type: String?
    var query: String?
}

class CurrentCondition: Codable {
    
    var observation_time: String?
    var temp_C: String?
    var temp_F: String?
    var weatherCode: String?
    var weatherIconUrl: [WeatherIconUrl]?
    var weatherDesc: [WeatherDesc]?
    var windspeedMiles: String?
    var windspeedKmph: String?
    var winddirDegree: String?
    var winddir16Point: String?
    var precipMM: String?
    var precipInches: String?
    var humidity: String?
    var visibility: String?
    var visibilityMiles: String?
    var pressure: String?
    var pressureInches: String?
    var cloudcover: String?
    var FeelsLikeC: String?
    var FeelsLikeF: String?
    var uvIndex: Int?


}

class WeatherIconUrl: Codable {
    
    var value: String?
    
}

class WeatherDesc: Codable {
    
    var value: String?
    
}

class Weather: Codable {
    
    var date: String?
    var astronomy: [Astronomy]?
    var maxtempC: String?
    var maxtempF: String?
    var mintempC: String?
    var mintempF: String?
    var avgtempC: String?
    var avgtempF: String?
    var totalSnow_cm: String?
    var sunHour: String?
    var uvIndex: String?
    var hourly: [Hourly]?

}

class Astronomy: Codable {
    
    var sunrise: String?
    var sunset: String?
    var moonrise: String?
    var moonset: String?
    var moon_phase: String?
    var moon_illumination: String?
}

class Hourly: Codable {
    
    var time: String?
    var temp_C: String?
    var temp_F: String?
    var windspeedMiles: String?
    var windspeedKmph: String?
    var winddirDegree: String?
    var winddir16Point: String?
    var weatherCode: String?
    var weatherIconUrl: [WeatherIconUrl]?
    var weatherDesc: [WeatherDesc]?
    var precipMM: String?
    var precipInches: String?
    var humidity: String?
    var visibility: String?
    var visibilityMiles: String?
    var pressure: String?
    var pressureInches: String?
    var cloudcover: String?
    var HeatIndexC: String?
    var HeatIndexF: String?
    var DewPointC: String?
    var DewPointF: String?
    var WindChillC: String?
    var WindChillF: String?
    var WindGustMiles: String?
    var WindGustKmph: String?
    var FeelsLikeC: String?
    var FeelsLikeF: String?
    var chanceofrain: String?
    var chanceofremdry: String?
    var chanceofwindy: String?
    var chanceofovercast: String?
    var chanceofsunshine: String?
    var chanceoffrost: String?
    var chanceofhightemp: String?
    var chanceoffog: String?
    var chanceofsnow: String?
    var chanceofthunder: String?
    var uvIndex: String?


}

class ClimateAvgs: Codable {
    
    var month: [Month]?
}

class Month: Codable {
    
    var index: String?
    var name: String?
    var avgMinTemp: String?
    var avgMinTemp_F: String?
    var absMaxTemp: String?
    var absMaxTemp_F: String?
    var avgDailyRainfall: String?
}


