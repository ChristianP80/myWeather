//
//  WeatherViewController.swift
//  myWeather
//
//  Created by Christian Persson on 2018-03-18.
//  Copyright © 2018 Christian Persson. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    
    var citys : [FavoriteCity] = []
    var serachController : UISearchController!
    var searchResult : [FavoriteCity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citys = createTempData()
        tableView.delegate = self
        tableView.dataSource = self
        
        definesPresentationContext = true
        serachController = UISearchController(searchResultsController: nil)
        serachController.searchResultsUpdater = self

        
        navigationItem.searchController = serachController
        
    }
    
    func createTempData() -> [FavoriteCity] {
        
        var tempCitys : [FavoriteCity] = []
        
        let city1 = FavoriteCity(image: #imageLiteral(resourceName: "fog"), cityName: "Göteborg", temperature: "10°")
        let city2 = FavoriteCity(image: #imageLiteral(resourceName: "light_rain"), cityName: "Stockholm", temperature: "6°")
        let city3 = FavoriteCity(image: #imageLiteral(resourceName: "sunny"), cityName: "Borås", temperature: "22°")
        let city4 = FavoriteCity(image: #imageLiteral(resourceName: "tstorm1"), cityName: "Norrköping", temperature: "4°")
        let city5 = FavoriteCity(image: #imageLiteral(resourceName: "tstorm3"), cityName: "Södertälje", temperature: "11°")
        let city6 = FavoriteCity(image: #imageLiteral(resourceName: "overcast"), cityName: "Halmstad", temperature: "10°")
        let city7 = FavoriteCity(image: #imageLiteral(resourceName: "snow4"), cityName: "Kiruna", temperature: "-2°")
        let city8 = FavoriteCity(image: #imageLiteral(resourceName: "snow5"), cityName: "Malmö", temperature: "-4°")
        let city9 = FavoriteCity(image: #imageLiteral(resourceName: "shower3"), cityName: "Varberg", temperature: "6°")
        let city10 = FavoriteCity(image: #imageLiteral(resourceName: "light_rain"), cityName: "Falkenberg", temperature: "3°")
        
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
    
    func updateSearchResults(for searchController: UISearchController) {

        if let text = serachController.searchBar.text?.lowercased() {
            searchResult = citys.filter({ $0.cityName.lowercased().contains(text) })
        } else {
            searchResult = []
        }
        tableView.reloadData()
    }
    
    var shouldUseSearchResult : Bool {
        if let text = serachController.searchBar.text {
            if text.isEmpty {
                return false
            } else {
                return serachController.isActive
            }
        } else {
            return false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldUseSearchResult {
            return searchResult.count
        } else {
            return citys.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as! WeatherCell
        
        let arrayToUse : [FavoriteCity]
        
        if shouldUseSearchResult {
            arrayToUse = searchResult
        } else {
            arrayToUse = citys
        }
        let tempData = arrayToUse[indexPath.row]

        
        cell.setTempData(tempData: tempData)
        
        return cell
    }
    

}

