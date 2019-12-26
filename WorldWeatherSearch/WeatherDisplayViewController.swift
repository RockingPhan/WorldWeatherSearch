//
//  WeatherDisplayViewController.swift
//  WorldWeatherSearch
//
//  Created by Phanindra Kumar  on 24/12/19.
//  Copyright © 2019 Phanindra Kumar . All rights reserved.
//

import UIKit

class WeatherDisplayViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var weatherDescLabel: UILabel!
    
    @IBOutlet weak var weatherIconImgView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var windValue: UILabel!
    
    @IBOutlet weak var feelsLikeValue: UILabel!
    
    @IBOutlet weak var humidityValue: UILabel!
    
    var selectedModel: SearchModelObject?
    
    var recentHistoryObjectsArray: [SearchModelObject]?
    
    var currentWeatherData: CurrentCondition?
    
    var cityRequestData: Request?
    
    var weatherServiceHandler: WeatherServiceAPIHandler!
    
    var cityTitle: String?
    
    let imageCache = NSCache<NSString, UIImage>()

    
    let localWeatherURLString = "https://api.worldweatheronline.com/premium/v1/weather.ashx"
    
    static let searchObjectsKey = "recent_search_objects"
    
    var activityIndicatorView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherServiceHandler = WeatherServiceAPIHandler()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let selectedLocationModel = selectedModel {
            
            var titleStr = ""
            if let areaName = selectedLocationModel.areaName, areaName.count>0 {
                
                titleStr = areaName[0].value ?? ""
            }
            if let country = selectedLocationModel.country, country.count>0 {
                titleStr.append(", ")
                titleStr.append(country[0].value ?? "")
            }
            
            cityTitle = titleStr
            
            if let latitude = selectedLocationModel.latitude, let longitude = selectedLocationModel.longitude {
                
                let location = "\(latitude),\(longitude)"
                showSpinner()
                getCurrentWeatherFromAPI(for: location)

            }
            
        }
        
            
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    
        selectedModel = nil
        removeSpinner()
    }
    
    func getCurrentWeatherFromAPI(for location: String ) {
           
        let successHandler: (LocalWeatherModel) -> Void = { (localWeatherModel) in
            if let currentweatherDataArr = localWeatherModel.data?.current_condition, currentweatherDataArr.count > 0 {
                
                self.currentWeatherData = currentweatherDataArr[0]
                self.setUpUIForCurrenWeather()
                self.removeSpinner()
                
            }
        }
           
           let errorHandler: (String) -> Void = { (error) in
               print(error)
              // self.view?.displayError(error: error)
              self.removeSpinner()

           }
           

           
           var parameters = [String: String]()
           
           parameters["q"] = location
           parameters["key"] = WeatherServiceAPIHandler.apiKey
           parameters["num_of_days"] = "0"
           parameters["format"] = "json"

           weatherServiceHandler.get(urlString: localWeatherURLString,
                                     params: parameters,
                            successHandler: successHandler,
                            errorHandler: errorHandler)
       }
    
    
    func setUpUIForCurrenWeather() {
        
        guard let currentWeather = currentWeatherData else {
            return
        }
        
        DispatchQueue.main.async {
            
            self.cityNameLabel.text = self.cityTitle
            
            if let weatherDescArr = currentWeather.weatherDesc, weatherDescArr.count > 0 {
                
                self.weatherDescLabel.text = weatherDescArr[0].value

            }
            
            self.temperatureLabel.text = NSString(format:"\(currentWeather.temp_C!)%@" as NSString, "\u{00B0}") as String
            
            self.windValue.text = "\(currentWeather.windspeedMiles!) mph"
            
            self.feelsLikeValue.text = NSString(format:"\(currentWeather.FeelsLikeC!)%@" as NSString, "\u{00B0}") as String

            self.humidityValue.text = "\(currentWeather.humidity!)%"
            
            self.addItemToSearchHistory()
                        
            if let weatherIconUrlArr = currentWeather.weatherIconUrl, weatherIconUrlArr.count > 0 {
                
                guard let iconImgUrlString = weatherIconUrlArr[0].value, let imageUrl = URL(string: iconImgUrlString)  else {
                    return
                }
                
                
                
                self.downloadImage(url: imageUrl, completion: { (iconImage, error) in
                    
                    if let error = error {
                        print("Couldn't download image: ", error)
                        return
                    }
                    guard let weatherIconImage = iconImage else { return }
                    DispatchQueue.main.async {
                        self.weatherIconImgView.image = weatherIconImage
                    }
                    
                })
                
            }

        }
        
        
        
    }
    
    
    
    
}

extension WeatherDisplayViewController {
    
    func showSpinner() {
        let spinnerView = UIView.init(frame: view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityView = UIActivityIndicatorView.init(style: .whiteLarge)
        activityView.startAnimating()
        activityView.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityView)
            self.view.addSubview(spinnerView)
        }
        
        activityIndicatorView = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.activityIndicatorView?.removeFromSuperview()
            self.activityIndicatorView = nil
        }
    }
    
}

extension WeatherDisplayViewController {
    
    func downloadImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
        } else {
             URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    
                } else if let data = data, let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image, nil)
                } else {
                    completion(nil, error)
                }
            }.resume()
        }
    }
    
}

extension WeatherDisplayViewController {
    
    func addItemToSearchHistory() {
        
        guard let searchModelObject = selectedModel else { return }
        
        let timestamp = Date().currentTimeMillis()
        
        searchModelObject.timeStamp = timestamp
        
        if let recentSearchObjectsArr = WeatherDisplayViewController.getAllRecentSearchObjects {
            recentHistoryObjectsArray = recentSearchObjectsArr
            if recentHistoryObjectsArray?.count == 10 {
                recentHistoryObjectsArray?.remove(at: 0)
            }
            
            if recentHistoryObjectsArray!.contains(where: { $0.latitude == searchModelObject.latitude && $0.longitude == searchModelObject.longitude}) {
                
                
                recentHistoryObjectsArray?.removeAll(where: { $0.latitude == searchModelObject.latitude && $0.longitude == searchModelObject.longitude})
                
            }

            
            recentHistoryObjectsArray?.append(searchModelObject)
            saveAllSearchObjects(searchObjects: recentHistoryObjectsArray!)
        } else {
            
            if recentHistoryObjectsArray != nil {
                
                recentHistoryObjectsArray?.removeAll()
            }
            recentHistoryObjectsArray = [SearchModelObject]()
            recentHistoryObjectsArray?.append(searchModelObject)
            saveAllSearchObjects(searchObjects: recentHistoryObjectsArray!)
        }
        
    }
    
     func saveAllSearchObjects(searchObjects: [SearchModelObject]) {
         let encoder = JSONEncoder()
         if let encoded = try? encoder.encode(searchObjects){
            UserDefaults.standard.set(encoded, forKey: WeatherDisplayViewController.searchObjectsKey)
         }
    }
    
    static var getAllRecentSearchObjects: [SearchModelObject]? {
        
        if let recentSearchObjects = UserDefaults.standard.value(forKey: WeatherDisplayViewController.searchObjectsKey) as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: recentSearchObjects) as [SearchModelObject] {
                return objectsDecoded
            }
        }
        return nil
    }
    
    
    
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
