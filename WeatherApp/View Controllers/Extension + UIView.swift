//
//  Extension + UIView.swift
//  WeatherApp
//
//  Created by Андрей Барсук on 25.05.2022.
//

import UIKit

extension UIView {
    func fadeIn() {
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.duration = 1
        fadeIn.fromValue = 0
        fadeIn.toValue = 1
        
        layer.add(fadeIn, forKey: nil)
    }
}

