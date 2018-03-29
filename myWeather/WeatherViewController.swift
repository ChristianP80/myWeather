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
    
    var citys : [WeatherModel] = []
    var serachController : UISearchController!
    var searchResult : [WeatherModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return citys.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as! WeatherCell
    
        
        cell.cityLabel.text = "Name of city"
        cell.tempLabel.text = "Temperature at city"
        
        return cell
    }
    

}

