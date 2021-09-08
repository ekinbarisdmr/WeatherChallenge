//
//  DetailPageViewModel.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 4.09.2021.
//

import UIKit
import Firebase

protocol DetailPageViewModelDelegate {
    func changedStatus(status: BaseViewController.RequestStatus)
    func savedCity(result: Bool)
}

class DetailPageViewModel: NSObject {

    var weatherDetails = DetailModel()
    var savedCities = [SaveModel]()
    var details = [Details]()
    var datesArray = [String]()
    var selectedCity = Int()
    var delegate: DetailPageViewModelDelegate?

    func fetchWeatherDetail() {
        API.sharedManager.getDetails(woeid: self.selectedCity) { [self] (response) in
            weatherDetails = response
            if let detail = response.consolidated_weather {
                details = detail
            }
            convertDates()
            self.savedCities = StoreManager.shared.getCity()
            self.delegate?.changedStatus(status: .completed(nil))

        } errorHandler: { (error) in
            self.delegate?.changedStatus(status: .unknown)
            print(error)
        }
    }
    
    func convertDates() {
        let getDate = DateFormatter()
        let convertedDate = DateFormatter()
        getDate.dateFormat = "yyyy-MM-dd"
        convertedDate.dateFormat = "E"
        for i in 0..<details.count {
            if let date = details[i].applicable_date, let firstDate = getDate.date(from: date) {
                let lastDate = convertedDate.string(from: firstDate)
                self.datesArray.append(lastDate)
            }
        }
    }
    
    @objc func saveCity(sender: UIBarButtonItem) {
        if let title = weatherDetails.title,
           let woeid = weatherDetails.woeid,
           let locationType = weatherDetails.location_type {
            
            Analytics.logEvent("saved_city", parameters: [
              "city_name": title as NSObject,
              
            ])
            
            let match = savedCities.enumerated().first(where: { $0.element.title == title})
            if match != nil {
                self.delegate?.savedCity(result: false)
            }
            else {
                let newCity = SaveModel(title: title, location_type: locationType, woeid: woeid)
                self.savedCities.insert(newCity, at: 0)
                StoreManager.shared.saveCity(data: self.savedCities)
                self.delegate?.savedCity(result: true)
            }
        }
    }
}

