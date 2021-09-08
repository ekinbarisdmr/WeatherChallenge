//
//  GradientView.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 5.09.2021.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor.gradient1Color(), UIColor.gradient2Color()]
        gradientLayer.startPoint = CGPoint(x: 0.70, y: 0.1)
        gradientLayer.endPoint = CGPoint(x: 0.1, y: 0.70)

    }
}
