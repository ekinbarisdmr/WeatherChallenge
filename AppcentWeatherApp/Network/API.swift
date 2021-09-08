//
//  API.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 2.09.2021.
//

import Foundation
import Alamofire

class API {
    
    static let sharedManager = API()
    private var sessionManager = SessionManager()
    private init() { }
    
    
    fileprivate let encoding = JSONEncoding.default
    
    func getWeathers(lattLong: String, sucees:@escaping ((_ status: [WeathersModel])-> Void), errorHandler:@escaping ((_ status: Bool)-> Void)){
        
        let endpoint = coordinatesRequestBaseUrl + "\(lattLong)"
        sessionManager.request(endpoint, method: .get,encoding: JSONEncoding.default).responseData { (response) in
            let result = response.result
            switch result {
                case .success(let data):
                    do {
                        let responseArray = try JSONDecoder().decode([WeathersModel].self, from: data)
                        sucees(responseArray)
                    } catch  {
                        errorHandler(true)
                    }
                case .failure(_ ):
                    errorHandler(true)
            }
        }
    }
    
    func getWeathers(query: String, sucees:@escaping ((_ status: [CityModel])-> Void), errorHandler:@escaping ((_ status: Bool)-> Void)){
        
        let endpoint = cityRequestBaseUrl + "\(query)"
        sessionManager.request(endpoint, method: .get,encoding: JSONEncoding.default).responseData { (response) in
            let result = response.result
            switch result {
                case .success(let data):
                    do {
                        let responseArray = try JSONDecoder().decode([CityModel].self, from: data)
                        sucees(responseArray)
                    } catch  {
                        errorHandler(true)
                    }
                case .failure(_ ):
                    errorHandler(true)
            }
        }
    }
    
    func getDetails(woeid: Int, sucees:@escaping ((_ status: DetailModel)-> Void), errorHandler:@escaping ((_ status: Bool)-> Void)){
        
        let endpoint = woeidRequestBaseUrl + "\(woeid)"
        sessionManager.request(endpoint, method: .get,encoding: JSONEncoding.default).responseData { (response) in
            let result = response.result
            switch result {
                case .success(let data):
                    do {
                        let responseArray = try JSONDecoder().decode(DetailModel.self, from: data)
                        sucees(responseArray)
                    } catch  {
                        errorHandler(true)
                    }
                case .failure(_ ):
                    errorHandler(true)
            }
        }
    }
}

