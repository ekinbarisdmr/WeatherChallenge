//
//  MainPageViewController.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 3.09.2021.
//

import UIKit
import Foundation

class MainPageViewController: BaseViewController {
    
    @IBOutlet weak var viewModel: MainPageViewModel!
    var searchButton = UIBarButtonItem()
    var savedCities = UIBarButtonItem()
    var saveButtonImage = savedButtonImage
    var pageTitle = mainPageTitle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        requestStatus = .pending
        checkInternetConnection()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.setupTableView()
        setupNavigatonController()
    }
    
    func setups() {
        viewModel.setupCLLocation()
        viewModel.setupTableView()
        setupNavigatonController()
        setFloatingButton()
        
    }
    
    func checkInternetConnection() {
        if CheckInternet.Connection() {
            setups()
        }
        else {
            Alert.showAlert(viewController: self, title: internetErrorTitle, message: internetErrorMessage)
        }
    }
    
    func setupNavigatonController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = UIColor.detailText2Color()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.detailText2Color()]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.detailText2Color()]
        self.navigationController?.setStatusBar(backgroundColor: .clear)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        self.navigationItem.title = self.pageTitle
        
        self.searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass") , style: .done, target: viewModel, action: #selector(viewModel.tappedSearch(sender:)))
        self.savedCities = UIBarButtonItem(image: UIImage(systemName: self.saveButtonImage), style: .done, target: viewModel, action: #selector(viewModel.tappedSavedList(sender:)))
        self.navigationItem.setRightBarButtonItems([searchButton, savedCities], animated: true)
    }
    
    func setFloatingButton() {
        viewModel.floatingButton.addTarget(self, action: #selector(self.upButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(viewModel.floatingButton)
    }
    
    @objc func upButtonTapped(_ sender: UIButton) {
        DispatchQueue.main.async { [self] in
            viewModel.tableView.setContentOffset(.zero, animated: true)
            viewModel.floatingButton.isHidden = true
        }
    }
}

extension MainPageViewController: MainPageViewModelDelegate {

    func tappedSavedButton(tapped: String, title: String) {
        self.saveButtonImage = tapped
        self.pageTitle = title
        setupNavigatonController()
    }
    
    func tappedSearchButton(tapped: Bool) {
        if tapped == true {
            guard let searchVc = mainDelegate.mainStoryboard.instantiateViewController(identifier: "SearchPageViewController") as? SearchPageViewController else { return }
            self.navigationController?.pushViewController(searchVc, animated: true)
        }
    }
    
    func selectedItem(weatherModel: Int) {
        guard let detailVc = mainDelegate.mainStoryboard.instantiateViewController(identifier: "DetailPageViewController") as? DetailPageViewController else { return }
        viewModel.saved = false
        detailVc.viewModel.selectedCity = weatherModel
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    func changedStatus(status: BaseViewController.RequestStatus) {
        requestStatus = status
        switch status {
            case .completed(let error):
                if error != nil {
                    print("Error")
                }
                else {
                    viewModel.tableView.reloadData()
                }
            case .unknown:
                Alert.showAlert(viewController: self, title: internetErrorTitle, message: internetErrorMessage)
            default: break
        }
    }    
}
