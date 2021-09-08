//
//  FloatingButton.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 6.09.2021.
//

import Foundation
import UIKit


class FloatingButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let bottomPadding = window?.safeAreaInsets.bottom
        frame = CGRect(x: UIScreen.main.bounds.width - 80 , y: UIScreen.main.bounds.height - bottomPadding! - 80, width: 56, height: 56)
        setImage(UIImage(named: "upicon"), for: .normal)
        backgroundColor = UIColor.systemGray5
        alpha = 0.7
        clipsToBounds = true
        layer.cornerRadius = 28
        layer.borderColor = UIColor.blue.cgColor
        layer.borderWidth = 0.01
    }
}
