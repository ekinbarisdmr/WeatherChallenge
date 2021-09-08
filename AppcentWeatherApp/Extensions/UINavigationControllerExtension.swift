//
//  UINavigationControllerExtension.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 3.09.2021.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func setStatusBar(backgroundColor: UIColor) {
         let statusBarFrame: CGRect
         if #available(iOS 13.0, *) {
             statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
         } else {
             statusBarFrame = UIApplication.shared.statusBarFrame
         }
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let topInset: CGFloat = window?.safeAreaInsets.top ?? statusBarFrame.height
        let statusBarView = UIView(frame: CGRect(x: statusBarFrame.origin.x, y: statusBarFrame.origin.y, width: statusBarFrame.width, height: topInset))
         statusBarView.backgroundColor = backgroundColor
         view.addSubview(statusBarView)
     }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.darkGray
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController?.setStatusBar(backgroundColor: UIColor.darkGray)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        definesPresentationContext = true
    }
}



