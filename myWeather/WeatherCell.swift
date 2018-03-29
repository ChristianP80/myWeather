//
//  WeatherCell.swift
//  myWeather
//
//  Created by Christian Persson on 2018-03-18.
//  Copyright © 2018 Christian Persson. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func setTempData(tempData : WeatherModel) {
     //   weatherImageView.image = tempData.image
        cityLabel.text = tempData.city
        tempLabel.text = String(tempData.temperature)
    }
    
}
