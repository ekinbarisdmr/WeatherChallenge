//
//  UITableViewExtension.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 7.09.2021.
//

import Foundation
import UIKit

extension UITableView {
    
    func register(_ type : UITableViewCell.Type) {
        let className = String(describing: type)
        self.register(UINib(nibName: className , bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T>(_ type: T.Type) -> T? {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className) as? T
    }
}
