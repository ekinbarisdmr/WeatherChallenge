//
//  SearchPageViewModel.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 4.09.2021.
//

import UIKit

protocol SearchPageViewModelDelegate {
    func changedStatus(status: BaseViewController.RequestStatus)
    func getCityList(response: [CityModel])
}

class SearchPageViewModel: NSObject {

    var delegate: SearchPageViewModelDelegate?

    func getCityList(cityName: String?) {
        API.sharedManager.getWeathersWithSearch(query: cityName ?? "") { (response) in
            self.delegate?.getCityList(response: response)
            self.delegate?.changedStatus(status: .completed(nil))
        } errorHandler: { (error) in
            self.delegate?.changedStatus(status: .unknown)
            print(error)
        }
    }
}
