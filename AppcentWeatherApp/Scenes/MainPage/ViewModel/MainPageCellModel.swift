//
//  MainPageCellModel.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 2.09.2021.
//

import Foundation
import UIKit

class MainPageCellModel: NSObject {
    
    var weatherModel: WeathersModel?
    init(weatherModel: WeathersModel = WeathersModel()) {
        self.weatherModel = weatherModel
    }
}

extension MainPageCellModel: MainPageTableViewCellDataSource {
    
    func distanceForCell(_ cell: MainPageTableViewCell) -> Int {
        if let distance = weatherModel?.distance {
            return distance
        }
        else {
            return 00
        }
    }
    
    func cityForCell(_ cell: MainPageTableViewCell) -> String {
        if let cityName = weatherModel?.title{
            return cityName
        }
        else {
            return ""
        }
    }
    
    func typeForCell(_ cell: MainPageTableViewCell) -> String {
        if let typeName = weatherModel?.location_type{
            return typeName
        }
        else {
            return ""
        }
    }  
}
