//
//  SearchPageViewModel.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 8.09.2021.
//

import UIKit

protocol SearchPageViewModelDelegate {
    func changedStatus(status: BaseViewController.RequestStatus)
    func getCityList(response: [CityModel])
}

class SearchPageViewModel: NSObject {

    var delegate: SearchPageViewModelDelegate?
    
    func getCityList(cityName: String?) {
        API.sharedManager.getWeathers(query: cityName ?? "") { (response) in
            self.delegate?.getCityList(response: response)
            self.delegate?.changedStatus(status: .completed(nil))
        } errorHandler: { (error) in
            print(error)
        }
    }
    
    
}
