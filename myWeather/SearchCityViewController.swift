//
//  SearchCityViewController.swift
//  myWeather
//
//  Created by Christian Persson on 2018-03-23.
//  Copyright © 2018 Christian Persson. All rights reserved.
//

import UIKit

protocol SearchCityDelegate {
    func searchForaNewCity(city: String)
}

class SearchCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    @IBOutlet weak var searchCityTableView: UITableView!
    
    var delegate : SearchCityDelegate?
    var citys: [String] = []
    var serachController : UISearchController!
    var searchResult : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        searchCityTableView.delegate = self
        searchCityTableView.dataSource = self
        
        definesPresentationContext = true
        serachController = UISearchController(searchResultsController: nil)
        serachController.searchResultsUpdater = self
        
        
        navigationItem.searchController = serachController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = serachController.searchBar.text?.lowercased() {
            searchResult = citys.filter({ $0.lowercased().contains(text) })
        } else {
            searchResult = []
        }
        searchCityTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldUseSearchResult {
            return searchResult.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchCell
        
        let arrayToUse : [String]
        
        if shouldUseSearchResult {
            arrayToUse = searchResult
        } else {
            arrayToUse = citys
        }
        let city = arrayToUse[indexPath.row]

        cell.cityNameLabel.text = city
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

