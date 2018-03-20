//
//  WeatherViewController.swift
//  myWeather
//
//  Created by Christian Persson on 2018-03-18.
//  Copyright © 2018 Christian Persson. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var citys : [TempData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citys = createTempData()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func createTempData() -> [TempData] {
        
        var tempCitys : [TempData] = []
        
        let city1 = TempData(image: #imageLiteral(resourceName: "fog"), cityName: "Göteborg", temperature: "10°")
        let city2 = TempData(image: #imageLiteral(resourceName: "light_rain"), cityName: "Sockholm", temperature: "6°")
        let city3 = TempData(image: #imageLiteral(resourceName: "sunny"), cityName: "Borås", temperature: "22°")
        let city4 = TempData(image: #imageLiteral(resourceName: "tstorm1"), cityName: "Norrköping", temperature: "4°")
        let city5 = TempData(image: #imageLiteral(resourceName: "tstorm3"), cityName: "Södertälje", temperature: "11°")
        let city6 = TempData(image: #imageLiteral(resourceName: "overcast"), cityName: "Halmstad", temperature: "10°")
        let city7 = TempData(image: #imageLiteral(resourceName: "snow4"), cityName: "Kiruna", temperature: "-2°")
        let city8 = TempData(image: #imageLiteral(resourceName: "snow5"), cityName: "Malmö", temperature: "-4°")
        let city9 = TempData(image: #imageLiteral(resourceName: "shower3"), cityName: "Varberg", temperature: "6°")
        let city10 = TempData(image: #imageLiteral(resourceName: "light_rain"), cityName: "Falkenberg", temperature: "3°")
        
        tempCitys.append(city1)
        tempCitys.append(city2)
        tempCitys.append(city3)
        tempCitys.append(city4)
        tempCitys.append(city5)
        tempCitys.append(city6)
        tempCitys.append(city7)
        tempCitys.append(city8)
        tempCitys.append(city9)
        tempCitys.append(city10)

        return tempCitys

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempData = citys[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as! WeatherCell
        
        cell.setTempData(tempData: tempData)
        
        return cell
    }
    

}
