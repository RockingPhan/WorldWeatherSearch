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
    var currentCondition: [CurrentCondition]?
    var weather: [Weather]?
    var climateAverages: [ClimateAvgs]
    
    enum CodingKeys: String, CodingKey {
        case request
        case currentCondition = "current_condition"
        case weather
        case climateAverages = "ClimateAverages"
        
    }
    
}

 class Request: Codable {
    
    var type: String?
    var query: String?
}

class CurrentCondition: Codable {
    
    var observationTime: String?
    var tempC: String?
    var tempF: String?
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
    var feelsLikeC: String?
    var feelsLikeF: String?
    var uvIndex: Int?
    
    enum CodingKeys: String, CodingKey {
        case observationTime = "observation_time"
        case tempC = "temp_C"
        case tempF = "temp_F"
        case weatherCode
        case weatherIconUrl
        case weatherDesc
        case windspeedMiles
        case windspeedKmph
        case winddirDegree
        case winddir16Point
        case precipMM
        case precipInches
        case humidity
        case visibility
        case visibilityMiles
        case pressure
        case pressureInches
        case cloudcover
        case feelsLikeC = "FeelsLikeC"
        case feelsLikeF = "FeelsLikeF"
        case uvIndex
    }
    
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
    var totalSnowCm: String?
    var sunHour: String?
    var uvIndex: String?
    var hourly: [Hourly]?
    
    enum CodingKeys: String, CodingKey {
        case date
        case astronomy
        case maxtempC
        case maxtempF
        case mintempC
        case mintempF
        case avgtempC
        case avgtempF
        case totalSnowCm = "totalSnow_cm"
        case sunHour
        case uvIndex
        case hourly
    }

}

class Astronomy: Codable {
    
    var sunrise: String?
    var sunset: String?
    var moonrise: String?
    var moonset: String?
    var moonphase: String?
    var moonIllumination: String?
    
    enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
        case moonrise
        case moonset
        case moonphase = "moon_phase"
        case moonIllumination = "moon_illumination"
    }
    
}

class Hourly: Codable {
    
    var time: String?
    var tempC: String?
    var tempF: String?
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
    var heatIndexC: String?
    var heatIndexF: String?
    var dewPointC: String?
    var dewPointF: String?
    var windChillC: String?
    var windChillF: String?
    var windGustMiles: String?
    var windGustKmph: String?
    var feelsLikeC: String?
    var feelsLikeF: String?
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
    
    enum CodingKeys: String, CodingKey {
          case time
          case tempC = "temp_C"
          case tempF = "temp_F"
          case windspeedMiles
          case windspeedKmph
          case winddirDegree
          case winddir16Point
          case weatherCode
          case weatherIconUrl
          case weatherDesc
          case precipMM
          case precipInches
          case humidity
          case visibility
          case visibilityMiles
          case pressure
          case pressureInches
          case cloudcover
          case heatIndexC = "HeatIndexC"
          case heatIndexF = "HeatIndexF"
          case dewPointC = "DewPointC"
          case dewPointF = "DewPointF"
          case windChillC = "WindChillC"
          case windChillF = "WindChillF"
          case windGustMiles = "WindGustMiles"
          case windGustKmph = "WindGustKmph"
          case feelsLikeC = "FeelsLikeC"
          case feelsLikeF = "FeelsLikeF"
          case chanceofrain
          case chanceofremdry
          case chanceofwindy
          case chanceofovercast
          case chanceofsunshine
          case chanceoffrost
          case chanceofhightemp
          case chanceoffog
          case chanceofsnow
          case chanceofthunder
          case uvIndex
    }
    
}

class ClimateAvgs: Codable {
    
    var month: [Month]?
}

class Month: Codable {
    
    var index: String?
    var name: String?
    var avgMinTemp: String?
    var avgMinTempF: String?
    var absMaxTemp: String?
    var absMaxTempF: String?
    var avgDailyRainfall: String?
    
    enum CodingKeys: String, CodingKey {
        case index
        case name
        case avgMinTemp
        case avgMinTempF = "avgMinTemp_F"
        case absMaxTemp
        case absMaxTempF = "absMaxTemp_F"
        case avgDailyRainfall
    }
    
}
