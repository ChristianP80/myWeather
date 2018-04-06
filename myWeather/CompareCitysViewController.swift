//
//  CompareCitysViewController.swift
//  myWeather
//
//  Created by Christian Persson on 2018-04-05.
//  Copyright © 2018 Christian Persson. All rights reserved.
//

import UIKit
import GraphKit
import Alamofire
import SwiftyJSON

class CompareCityViewController: UIViewController, GKBarGraphDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var graph: GKBarGraph!
    @IBOutlet weak var cityPicker: UIPickerView!
    
    
    let userDefaults = UserDefaults.standard
    var favCitys : [String] = []
    var weatherJSON : JSON = JSON.null
    var modelArray : [WeatherModel] = []
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "a41c95ab72c869ec929effc87d524984"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        favCitys = userDefaults.stringArray(forKey: "SavedFavoriteCitys") ?? [String]()
        print("\(favCitys)")
        cityPicker.dataSource = self
        cityPicker.delegate = self
        graph.dataSource = self
    }
    
    @IBAction func compareCitiesPressed(_ sender: UIButton) {
        sender.pulsate()
        updateLabel()
    }
    
    func updateLabel(){
        let city1 = favCitys[cityPicker.selectedRow(inComponent: 0)]
        let city2 = favCitys[cityPicker.selectedRow(inComponent: 1)]
        let params1 : [String : String] = ["q" : city1, "appid" : APP_ID]
        let params2 : [String : String] = ["q" : city2, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params1)
        getWeatherData(url: WEATHER_URL, parameters: params2)
        

        print("your citys are \(city1), \(city2)")
   
    }

    func numberOfBars() -> Int {
        return 2
    }
    
    func valueForBar(at index: Int) -> NSNumber! {
        return modelArray[index].temperature as NSNumber
    }
    
    func titleForBar(at index: Int) -> String! {
        return "Temp"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return favCitys.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return favCitys[row]
    }
    
    func getWeatherData(url: String, parameters: [String : String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success, got the weatherdata")
                
                self.weatherJSON = JSON(response.result.value!)
                print(self.weatherJSON)
                self.updateWeatherData(json: self.weatherJSON)
                
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    func updateWeatherData(json : JSON) {
        
        if let tempResult = json["main"]["temp"].double {
            let weatherModel = WeatherModel()
            weatherModel.temperature = Int(tempResult - 273.15)
            weatherModel.city = json["name"].stringValue
            weatherModel.condition = json["weather"][0]["id"].intValue
            weatherModel.weatherIconName = weatherModel.updateWeatherIcon(condition: weatherModel.condition)
            weatherModel.humidity = json["main"]["humidity"].intValue
            weatherModel.windSpeed = json["wind"]["speed"].floatValue
            modelArray.append(weatherModel)
            if modelArray.count > 1 {
                updateGraph(weathermodel : weatherModel)
            }
        } else {
            print("Weather unavailable")
        }
    }
    func updateGraph(weathermodel : WeatherModel) {
        print("\(modelArray[0].city)")
        print("\(modelArray[1].city)")
        graph.barWidth = 150.0
        graph.draw()
        modelArray = []
    }

    
}


