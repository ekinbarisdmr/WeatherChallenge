//
//  MainPageViewModel.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 3.09.2021.
//

import UIKit
import CoreLocation

protocol MainPageViewModelDelegate {
    func changedStatus(status: BaseViewController.RequestStatus)
    func selectedItem(weatherModel: Int)
    func tappedSearchButton(tapped: Bool)
    func tappedSavedButton(tapped: String, title: String)
}

class MainPageViewModel: NSObject {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainView: GradientView!
    var locationManager: CLLocationManager = CLLocationManager()
    var delegate: MainPageViewModelDelegate?
    var weatherList = [WeathersModel]()
    var savedCities = [SaveModel]()
    let floatingButton = FloatingButton()
    var coordinates = String()
    var saved = false
    
    func setupTableView() {
        tableView.register(MainPageTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.reloadData()
    }
    
    func setupCLLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func fetchWeathers() {
        API.sharedManager.getWeathers(lattLong: self.coordinates) { (response) in
            self.weatherList = response
            self.delegate?.changedStatus(status: .completed(nil))
            self.tableView.reloadData()
        } errorHandler: { (error) in
            self.delegate?.changedStatus(status: .unknown)
            print(error)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        floatingButton.isHidden = true
        if currentOffset > 160 {
            floatingButton.isHidden = false
        }
        else {
            floatingButton.isHidden = true
        }
    }
    
    @objc func tappedSearch(sender: UIBarButtonItem) {
        self.delegate?.tappedSearchButton(tapped: true)
    }
    
    @objc func tappedSavedList(sender: UIBarButtonItem) {
        if saved {
            saved = false
            self.delegate?.tappedSavedButton(tapped: "book", title: mainPageTitle)
            fetchWeathers()
        }
        else {
            saved = true
            self.delegate?.tappedSavedButton(tapped: "book.fill", title: savePageTitle)
            self.savedCities = StoreManager.shared.getCity()
            tableView.reloadData()
        }
    }
}
//MARK: UITableViewDataSource

extension MainPageViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if saved {
            return savedCities.count
        }
        else {
            return weatherList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MainPageTableViewCell.self)!
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        if saved {
            cell.cityLabel.text = savedCities[indexPath.row].title
            cell.typeLabel.text = savedCities[indexPath.row].location_type
            cell.distanceLabel.text = ""
        }
        else {
            var mainPageCellModel = MainPageCellModel()
            mainPageCellModel = MainPageCellModel(weatherModel: weatherList[indexPath.row])
            cell.dataSource = mainPageCellModel
            cell.reloadData()
        }
        return cell
    }
}

extension MainPageViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if saved {
            self.delegate?.selectedItem(weatherModel: savedCities[indexPath.row].woeid ?? 0)
        }
        else {
            self.delegate?.selectedItem(weatherModel: weatherList[indexPath.row].woeid ?? 0)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if saved {
            if editingStyle == UITableViewCell.EditingStyle.delete {
                savedCities.remove(at: indexPath.row)
                StoreManager.shared.saveCity(data: savedCities)
                tableView.reloadData()
            }
        }
        else {
            mainView.shake()
        }
    }
}

extension MainPageViewModel: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation: CLLocation = locations[locations.count - 1]
        let longitude = "\((lastLocation.coordinate.longitude).round(to: 2))"
        let latitude = "\((lastLocation.coordinate.latitude).round(to: 2))"
        self.coordinates = "\(latitude),\(longitude)"
        self.locationManager.stopUpdatingLocation()
        self.fetchWeathers()
    }
}


