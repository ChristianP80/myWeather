//
//  CurrentWeatherViewController.swift
//  myWeather
//
//  Created by Christian Persson on 2018-03-21.
//  Copyright © 2018 Christian Persson. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class CurrentWeatherViewController: UIViewController, CLLocationManagerDelegate, SearchCityDelegate {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var weatherConditionImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var navSearchButton: UIBarButtonItem!
    
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "a41c95ab72c869ec929effc87d524984"
    
    var weatherJSON : JSON = JSON.null
    var favoriteCitys : [String] = []
    let locationManager = CLLocationManager()
    let weatherModel = WeatherModel()
    var cityArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navSearchButton.isEnabled = false
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let queue = DispatchQueue(label: "Load JSON")
        queue.async {
            self.readJson()
        }
        
        print("Hej!")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            let params : [String : String] = ["lat" : "\(latitude)", "lon" : "\(longitude)", "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
            locationManager.delegate = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location unavailable"
    }
    
    func getWeatherData(url: String, parameters: [String : String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success, got the weatherdata")
                
                self.weatherJSON = JSON(response.result.value!)
               // print(self.weatherJSON)
                self.updateWeatherData(json: self.weatherJSON)
                
            } else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    func updateWeatherData(json : JSON) {
        
        if let tempResult = json["main"]["temp"].double {
        
            weatherModel.temperature = Int(tempResult - 273.15)
            weatherModel.city = json["name"].stringValue
            weatherModel.condition = json["weather"][0]["id"].intValue
            weatherModel.weatherIconName = weatherModel.updateWeatherIcon(condition: weatherModel.condition)
            updateGUI()
        } else {
            cityLabel.text = "Weather unavailable"
        }
    }
    
    func readJson(){
        if let path = Bundle.main.path(forResource: "city.list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                
                createCityArray(jsonObj: jsonObj)
                navSearchButton.isEnabled = true
//                print("city array = \(cityArray)")
//                print("jsonData:\(jsonObj[0]["name"])")
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        
    }
    
    func createCityArray(jsonObj: JSON) {
        
        let arr = jsonObj.array!
        for index in 0..<arr.count {
            let obj = arr[index]
            let cityName = obj["name"].string!
            cityArray.append(cityName)
        }
//        for city in jsonObj["name"] {
//            cityArray.append(city)
//        }


    }
    
    func updateGUI() {
        
        cityLabel.text = weatherModel.city
        tempLabel.text = String(weatherModel.temperature) + ("°")
        weatherConditionImageView.image = UIImage(named: weatherModel.weatherIconName)
        
    }
    
    func searchForaNewCity(city: String) {

        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        
        getWeatherData(url: WEATHER_URL, parameters: params)
        
    }
    
    @IBAction func saveAsFavoritePressed(_ sender: UIButton) {
        
        favoriteCitys.append(cityLabel.text!)
        print("My favorites \(favoriteCitys)")
        performSegue(withIdentifier: "favorites", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchCity" {
            
            let destinationVC = segue.destination as! SearchCityViewController
            
            destinationVC.delegate = self
            
            destinationVC.citys = cityArray
            
        }
        
        if segue.identifier == "favorites" {
            
            let destinationVC = segue.destination as! WeatherViewController
            
            //destinationVC.citys = cityArray
            
        }
        
    }
}
