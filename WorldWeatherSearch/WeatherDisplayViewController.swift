//
//  WeatherDisplayViewController.swift
//  WorldWeatherSearch
//
//  Created by Phanindra Kumar  on 24/12/19.
//  Copyright © 2019 Phanindra Kumar . All rights reserved.
//

import UIKit

class WeatherDisplayViewController: UIViewController {
    
    var selectedModel: SearchModelObject?
    
    var currentWeatherData: CurrentCondition?
    
    var weatherServiceHandler: WeatherServiceAPIHandler!
    
    let localWeatherURLString = "https://api.worldweatheronline.com/premium/v1/weather.ashx"
    
    var activityIndicatorView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherServiceHandler = WeatherServiceAPIHandler()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let selectedLocationModel = selectedModel {
            
            var titleStr: String?
            if let areaName = selectedLocationModel.areaName, areaName.count>0 {
                
                titleStr = areaName[0].value
            }
            if let country = selectedLocationModel.country, country.count>0 {
                                
                titleStr?.append(country[0].value ?? "")
            }
            
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
                print(localWeatherModel)
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
