//
//  UIView.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 5.09.2021.
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }
    
    func addCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func gradientView(view: UIView) {
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [UIColor.gradient1Color(), UIColor.gradient2Color()]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.addSublayer(layer)
    }     
}
