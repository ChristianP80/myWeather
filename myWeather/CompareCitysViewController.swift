//
//  CompareCitysViewController.swift
//  myWeather
//
//  Created by Christian Persson on 2018-04-05.
//  Copyright © 2018 Christian Persson. All rights reserved.
//

import UIKit
import GraphKit

class CompareCityViewController: UIViewController, GKBarGraphDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var graph1: GKBarGraph!
    @IBOutlet weak var graph2: GKBarGraph!
    @IBOutlet weak var cityPicker1: UIPickerView!
    @IBOutlet weak var cityPicker2: UIPickerView!
    
    
    let userDefaults = UserDefaults.standard
    var favCitys : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favCitys = userDefaults.stringArray(forKey: "SavedFavoriteCitys") ?? [String]()
        print("\(favCitys)")
        cityPicker1.dataSource = self
        cityPicker1.delegate = self
        cityPicker2.delegate = self
        cityPicker2.dataSource = self
        graph1.dataSource = self
        graph2.dataSource = self
        graph2.draw()
        graph1.draw()
        
        
        // Do any additional setup after loading the view.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabel()
    }
    
    func updateLabel(){
        let city1 = favCitys[cityPicker1.selectedRow(inComponent: 0)]
        let city2 = favCitys[cityPicker2.selectedRow(inComponent: 0)]
        print("your citys are \(city1), \(city2)")
    }

    func numberOfBars() -> Int {
        return 3
    }
    
    func valueForBar(at index: Int) -> NSNumber! {
        return index * 10 as NSNumber
    }
    
    func titleForBar(at index: Int) -> String! {
        return "\(index)"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return favCitys.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return favCitys[row]
    }
    
    
    
}


