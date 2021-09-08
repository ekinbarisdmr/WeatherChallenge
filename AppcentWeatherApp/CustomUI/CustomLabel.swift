//
//  CustomLabel.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 5.09.2021.
//

import Foundation
import UIKit

class CustomGrayLabel: UILabel {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textColor = UIColor.detailTextColor()
    }
}

class CustomWhiteLabel: UILabel {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textColor = UIColor.detailText2Color()
    }
}
