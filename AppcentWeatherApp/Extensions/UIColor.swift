//
//  UIColor.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 5.09.2021.
//

import Foundation
import UIKit

extension UIColor {
    
    class func detailBgColor() -> UIColor {
        return UIColor(red: 1/255, green: 4/255, blue: 9/255, alpha: 1.0)
    }
    
    class func detailTextColor() -> UIColor {
        return UIColor(red: 100/255, green: 99/255, blue: 135/255, alpha: 1.0)
    }
    
    class func detailText2Color() -> UIColor {
        return UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
    }
    
    class func gradient1Color() -> CGColor {
        return CGColor(red: 18/255, green: 200/255, blue: 244/255, alpha: 1.0)
    }
    
    class func gradient2Color() -> CGColor {
        return CGColor(red: 16/255, green: 74/255, blue: 240/255, alpha: 1.0)
    } 
}
