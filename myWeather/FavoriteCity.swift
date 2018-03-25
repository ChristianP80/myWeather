//
//  TempData.swift
//  myWeather
//
//  Created by Christian Persson on 2018-03-18.
//  Copyright © 2018 Christian Persson. All rights reserved.
//

import Foundation
import UIKit

class FavoriteCity {
    
    var image : UIImage
    var cityName : String
    var temperature : String
    
    init(image : UIImage, cityName : String, temperature : String) {
        self.image = image
        self.cityName = cityName
        self.temperature = temperature
    }
    
}
