//
//  MainPageTableViewCell.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 3.09.2021.
//

import UIKit

protocol MainPageTableViewCellDataSource {
    func cityForCell(_ cell: MainPageTableViewCell) -> String
    func typeForCell(_ cell: MainPageTableViewCell) -> String
    func distanceForCell(_ cell: MainPageTableViewCell) -> Int
}

class MainPageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var cityLabel: CustomWhiteLabel!
    @IBOutlet weak var typeLabel: CustomWhiteLabel!
    @IBOutlet weak var distanceLabel: CustomGrayLabel!
    var dataSource: MainPageTableViewCellDataSource?

    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.backgroundColor = .clear
    }

    func reloadData() {
        cityLabel.text = dataSource?.cityForCell(self)
        typeLabel.text = dataSource?.typeForCell(self)
        if let distance = dataSource?.distanceForCell(self) {
            if distance > 1000 {
                let distanceKm = distance / 1000
                distanceLabel.text = "\(distanceKm) km."
            }
            else {
                distanceLabel.text = "\(distance) m."
            }
        }
    }
}
