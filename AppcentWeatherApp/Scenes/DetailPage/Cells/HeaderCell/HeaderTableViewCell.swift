//
//  HeaderTableViewCell.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 4.09.2021.
//

import UIKit
import Kingfisher

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: GradientView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var windImageView: UIImageView!
    @IBOutlet weak var humidityImageView: UIImageView!
    @IBOutlet weak var visibilityImageView: UIImageView!
    @IBOutlet weak var cityLabel: CustomWhiteLabel!
    @IBOutlet weak var dayLabel: CustomWhiteLabel!
    @IBOutlet weak var maxTempLabel: CustomWhiteLabel!
    @IBOutlet weak var minTempLabel: CustomGrayLabel!
    @IBOutlet weak var weatherLabel: CustomGrayLabel!
    @IBOutlet weak var lineView: CustomGrayLabel!
    @IBOutlet weak var windKmLabel: CustomWhiteLabel!
    @IBOutlet weak var humidityRateLabel: CustomWhiteLabel!
    @IBOutlet weak var visibilityKmLabel: CustomWhiteLabel!
    @IBOutlet weak var visibilityLabel: CustomGrayLabel!
    @IBOutlet weak var windLabel: CustomGrayLabel!
    @IBOutlet weak var humidityLabel: CustomGrayLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        DispatchQueue.main.async {
            self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 60)
        }
    }
    
    func configure(_ detailModel: DetailModel) {
        
        if let details = detailModel.consolidated_weather {
            let detay = details[0]
            
            if let maxTemp = (detay.the_temp)?.round(to: 0) {
                maxTempLabel.text = "\(maxTemp)°"
            }
            
            if let minTemp = (detay.min_temp)?.round(to: 0) {
                minTempLabel.text = "/\(minTemp)°"
            }
            
            //            weatherLabel.text = detay.weather_state_name ?? " - "
            if let weatherStatus = detay.weather_state_name {
                weatherLabel.text = weatherStatus
            }
            
            if let windKm = (detay.wind_speed)?.round(to: 0) {
                windKmLabel.text = "\(windKm) km/h"
            }
            
            if let humidityRate = detay.humidity {
                humidityRateLabel.text = "\(humidityRate)%"
            }
            
            if let visibility = (detay.visibility)?.round(to: 0) {
                visibilityKmLabel.text = "\(visibility) km"
            }
            
            if let img = detay.weather_state_abbr {
                let url = "https://www.metaweather.com/static/img/weather/ico/\(img).ico"
                if let imageUrl = URL(string: url) {
                    weatherImageView.kf.setImage(with: imageUrl, placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
                    weatherImageView.clipsToBounds = true
                    weatherImageView.contentMode = .scaleAspectFit
                }
            }
        }
        dayLabel.text = "Today"
        windLabel.text = "Wind"
        humidityLabel.text = "Humidity"
        visibilityLabel.text = "Visibility"
        cityLabel.text = detailModel.title
    }
}
