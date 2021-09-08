//
//  Double.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 3.09.2021.
//

import Foundation
import UIKit

extension Double {
    
    func round(to decimalPlaces: Int) -> Double {
        let precisionNumber = pow(10,Double(decimalPlaces))
        var n = self 
        n = n * precisionNumber
        n.round()
        n = n / precisionNumber
        return n
    }
}
