//
//  DetailModel.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 3.09.2021.
//

import Foundation


struct DetailModel: Codable {
    
    var consolidated_weather : [Details]?
    var time : String?
    var sun_rise : String?
    var sun_set : String?
    var timezone_name : String?
    var parent : Parent? 
    var sources : [Sources]?
    var title : String?
    var location_type : String?
    var woeid : Int?
    var latt_long : String?
    var timezone : String?
    
}

struct Parent: Codable {
    var title : String?
    var location_type : String?
    var woeid : Int?
    var latt_long : String?

}

struct Sources: Codable {
    var title : String?
    var slug : String?
    var url : String?
    var crawl_rate : Int?
}

struct Details: Codable {

    var id : Int?
    var weather_state_name : String?
    var weather_state_abbr : String?
    var wind_direction_compass : String?
    var created : String?
    var applicable_date : String?
    var min_temp : Double?
    var max_temp : Double?
    var the_temp : Double?
    var wind_speed : Double?
    var wind_direction : Double?
    var air_pressure : Double?
    var humidity : Int?
    var visibility : Double?
    var predictability : Int?

}
