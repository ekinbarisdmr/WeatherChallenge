//
//  StoreManager.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 7.09.2021.
//

import Foundation
import UIKit

class StoreManager {
    
    static let shared = StoreManager()
    
    
    static func storeCity(data : [SaveModel]) -> NSData {
        return NSKeyedArchiver.archivedData(withRootObject: data as NSArray) as NSData
    }
    
    func loadCity() -> [SaveModel]? {
        if let unarchivedObject = UserDefaults.standard.object(forKey: "city") as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [SaveModel]
        }
        return nil
    }
    
    func getCity() -> [SaveModel] {
        var city: [SaveModel] = [SaveModel]()
        if StoreManager.shared.loadCity() == nil {
            StoreManager.shared.saveCity(data: city)
        }
        else {
            city = StoreManager.shared.loadCity() ?? []
        }
        return city
    }
    
    func saveCity(data : [SaveModel]?) {
        let archivedObject = StoreManager.storeCity(data: data!)
        UserDefaults.standard.set(archivedObject, forKey: "city")
        UserDefaults.standard.synchronize()
    }
}
