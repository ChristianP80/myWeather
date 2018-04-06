//
//  ButtonExtension.swift
//  myWeather
//
//  Created by Christian Persson on 2018-04-06.
//  Copyright © 2018 Christian Persson. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 2
        pulse.fromValue = 0.2
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
}
