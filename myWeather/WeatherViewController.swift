//
//  WeatherViewController.swift
//  myWeather
//
//  Created by Christian Persson on 2018-03-18.
//  Copyright © 2018 Christian Persson. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol searchWithFavoriteDelegate {
    func searchForaNewCity(city : String)
}

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "a41c95ab72c869ec929effc87d524984"
    
    var citys : [String] = []
    var delegate : searchWithFavoriteDelegate?
    let weatherModel = WeatherModel()
    var weatherJSON : JSON = JSON.null
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func getWeatherData(url: String, parameters: [String : String], cell : WeatherCell) {
//        for city in citys {
//            print("getWeatherDataCity \(city)")
//        }
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success, got the weatherdata")
                
                self.weatherJSON = JSON(response.result.value!)
               // print(self.weatherJSON)
                self.updateWeatherData(json: self.weatherJSON, cell : cell)
                
            } else {
                print("Error \(String(describing: response.result.error))")
//                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    func updateWeatherData(json : JSON, cell : WeatherCell) {
        
        if let tempResult = json["main"]["temp"].double {
            print("alla städer i listan är \(citys)")
            weatherModel.temperature = Int(tempResult - 273.15)
            weatherModel.city = json["name"].stringValue
            weatherModel.condition = json["weather"][0]["id"].intValue
            weatherModel.weatherIconName = weatherModel.updateWeatherIcon(condition: weatherModel.condition)
            weatherModel.humidity = json["main"]["humidity"].intValue
            weatherModel.windSpeed = json["wind"]["speed"].floatValue
            
           // DispatchQueue.main.async {
                cell.cityLabel.text = self.weatherModel.city
                cell.tempLabel.text = String("\(self.weatherModel.temperature)" + "℃")
                cell.weatherImageView.image = UIImage(named: self.weatherModel.weatherIconName)
           // }
            
            
            print(weatherModel.city)
            print(weatherModel.humidity)
            print(weatherModel.temperature)
            print(weatherModel.windSpeed)
        } else {
//            cityLabel.text = "Weather unavailable"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return citys.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as! WeatherCell
        let params : [String : String] = ["q" : citys[indexPath.row], "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params, cell : cell)
        print(params)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row \(indexPath.row)")
        print("Selected city = \(citys[indexPath.row])")
        let city = citys[indexPath.row]
        delegate?.searchForaNewCity(city: city)
        navigationController?.popViewController(animated: true)

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            citys.remove(at: indexPath.row)
            defaults.set(citys, forKey: "SavedFavoriteCitys")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

