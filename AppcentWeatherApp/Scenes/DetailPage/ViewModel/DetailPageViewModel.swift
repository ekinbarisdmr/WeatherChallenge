//
//  DetailPageViewModel.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 7.09.2021.
//

import UIKit


protocol DetailPageViewModelDelegate {
    func changedStatus(status: BaseViewController.RequestStatus)
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
            print(title)
            
            let match = savedCities.enumerated().first(where: { $0.element.title == title})
            if match != nil {
                print("hata")
            }
            else {
                let newCity = SaveModel(title: title, location_type: locationType, woeid: woeid)
                self.savedCities.insert(newCity, at: 0)
                StoreManager.shared.saveCity(data: self.savedCities)
            }
            

        }
    }
}

