//
//  SearchBar.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 6.09.2021.
//

import Foundation
import UIKit

protocol CustomSearchBarOutputDelegate {
    func changeText(text: String?)
}

class CustomSearchBar: UISearchBar {
    
    var output: CustomSearchBarOutputDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Please entry city name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.detailTextColor(), NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 13.0)!])
        searchTextField.textColor = UIColor.detailTextColor()
        searchTextField.backgroundColor = .white
        searchTextField.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        sizeToFit()
        tintColor = .gray
        barStyle = .default
        barTintColor = UIColor.black
        isTranslucent = false
        isHidden = false
        self.delegate = self
        setShowsCancelButton(true, animated: true)
        endEditing(true)
        
        let attributes: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.detailText2Color(), .font: UIFont(name: "HelveticaNeue-Bold", size: 16.0)!]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        
        for view in subviews {
            for subview in view.subviews where subview.isKind(of: NSClassFromString("UISearchBarBackground")!) {
                subview.alpha = 0
            }
        }
    }
}

extension CustomSearchBar: UISearchBarDelegate, UISearchControllerDelegate  {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        output?.changeText(text: "")
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        output?.changeText(text: "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.setupSearch), object: nil)
            self.perform(#selector(self.setupSearch), with: nil, afterDelay: 0.5)
        }
        else {
            output?.changeText(text: "")
        }
    }
    @objc func setupSearch() {
        output?.changeText(text: self.text)
    }
}
