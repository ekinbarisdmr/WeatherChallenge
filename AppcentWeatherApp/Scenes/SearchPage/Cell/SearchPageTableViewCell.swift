//
//  SearchPageTableViewCell.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 3.09.2021.
//

import UIKit

class SearchPageTableViewCell: UITableViewCell {

    @IBOutlet weak var cityName: CustomWhiteLabel!
    @IBOutlet weak var cityType: CustomGrayLabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ resultModel: CityModel) {
        cityName.text = resultModel.title
        cityType.text = resultModel.location_type
    }
}
