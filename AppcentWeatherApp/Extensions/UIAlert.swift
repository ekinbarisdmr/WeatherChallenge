//
//  UIAlert.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 5.09.2021.
//

import Foundation
import UIKit

class Alert {

    class func showAlert(viewController: UIViewController, title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
