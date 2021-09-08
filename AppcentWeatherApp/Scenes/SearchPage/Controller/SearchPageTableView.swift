//
//  SearchPageTableView.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 7.09.2021.
//

import Foundation
import UIKit

class SearchPageTableView: UITableView {
    
    var cityList: [CityModel]? {
        didSet {
            self.reloadData()
        }
    }
    var selected : (Int) -> () = { _ in }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        
    }
}

extension SearchPageTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selected(indexPath.row)
    }
    
}

extension SearchPageTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(SearchPageTableViewCell.self)!
        let city = cityList?[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.cityName.text = city?.title
        cell.cityType.text = city?.location_type
        return cell
    }   
}
