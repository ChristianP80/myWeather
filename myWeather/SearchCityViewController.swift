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

class SearchCityViewController: UIViewController {
    
    
    @IBOutlet weak var searchCityTableVoew: UITableView!
    
    var delegate : SearchCityDelegate?
//
//    @IBOutlet weak var navBar: UINavigationBar!
//    @IBOutlet weak var searchCityTextField: UITextField!
//    @IBAction func serachCityPressed(_ sender: AnyObject) {
//
//        let city = searchCityTextField.text!
//
//        delegate?.searchForaNewCity(city: city)
//
//        self.dismiss(animated: true, completion: nil)
//    }
}

