//
//  DetailPageTableViewCell.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 4.09.2021.
//

import UIKit
import Kingfisher

class DetailPageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: CustomWhiteLabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherLabel: CustomWhiteLabel!
    @IBOutlet weak var maxTempLabel: CustomGrayLabel!
    @IBOutlet weak var minTempLabel: CustomWhiteLabel!
    var datesArray = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func getDate(dates: [String]) {
        self.datesArray = dates
    }
    
    func configure(_ model: Details) {
        
        if let maxTemp = (model.max_temp)?.round(to: 0) {
            maxTempLabel.text = "\(maxTemp)°"
        }
        
        if let minTemp = (model.min_temp)?.round(to: 0) {
            minTempLabel.text = "\(minTemp)°"
        }
        
        if let weatherStatus = model.weather_state_name {
            weatherLabel.text = weatherStatus
        }
        
        if let img = model.weather_state_abbr {
            let url = "https://www.metaweather.com/static/img/weather/ico/\(img).ico"
            if let imageUrl = URL(string: url) {
                weatherImageView.kf.setImage(with: imageUrl, placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
               
            }
        }
        dayLabel.textColor = UIColor.detailTextColor()
        weatherLabel.textColor = UIColor.detailTextColor()
        minTempLabel.textColor = UIColor.detailTextColor()
        maxTempLabel.textColor = UIColor.detailText2Color()
        
    }
}
