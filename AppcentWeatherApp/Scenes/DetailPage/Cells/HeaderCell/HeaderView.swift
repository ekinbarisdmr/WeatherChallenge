//
//  HeaderView.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 8.09.2021.
//

import UIKit
import Firebase

class HeaderView: UIView {

    @IBOutlet var contentView: UIView!
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

    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
           
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }
    
    func commonInit() {
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        contentView.fixInView(self)
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
            
            DispatchQueue.main.async {
                self.mainView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 60)
               
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
        
        Analytics.logEvent("review_city", parameters: [
            "city_name": detailModel.title ?? "-" as String,
          
        ])
    }
}

extension UIView {
    
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}

