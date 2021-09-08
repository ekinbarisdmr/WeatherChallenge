//
//  RequestModel.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 7.09.2021.
//

import Foundation
import UIKit

class SaveModel: NSObject, NSCoding {
    
    var title: String?
    var location_type: String?
    var woeid: Int?
    
    init(title: String, location_type: String, woeid: Int) {
        self.title = title
        self.location_type = location_type
        self.woeid = woeid
    }
    
    required convenience init(coder aCoder: NSCoder) {
        let title = aCoder.decodeObject(forKey: "title") as! String
        let location_type = aCoder.decodeObject(forKey: "location_type") as! String
        let woeid = aCoder.decodeObject(forKey: "woeid") as! Int

        self.init( title: title, location_type: location_type, woeid: woeid)
    }
    
    func encode(with acoder: NSCoder) {
        acoder.encode(title,forKey: "title")
        acoder.encode(location_type,forKey: "location_type")
        acoder.encode(woeid,forKey: "woeid")

    }
}
