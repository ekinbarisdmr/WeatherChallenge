//
//  SearchPageViewController.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 3.09.2021.
//

import UIKit

class SearchPageViewController: BaseViewController {
    
    @IBOutlet weak var tableView: SearchPageTableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var searchBar: CustomSearchBar!
    @IBOutlet weak var viewModel: SearchPageViewModel!
    let floatingButton = FloatingButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestStatus = .pending
        viewModel.delegate = self
        checkInternet()
                
    }

    func setups() {
        setupTableView()
        setupSearchBar()
        setFloatingButton()
        setupNavigationBar()
        hideKeyboardWhenTappedAround()

    }
    
    func setupNavigationBar() {
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationItem.title = "Search City"
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.setStatusBar(backgroundColor: .clear)
        definesPresentationContext = true
        self.navigationItem.backBarButtonItem = backButton
    }
    
    func checkInternet() {
        if CheckInternet.Connection() {
            setups()
            requestStatus = .completed(nil)
        }
        else {
            Alert.showAlert(viewController: self, title: internetErrorTitle, message: internetErrorMessage)
        }
    }
    
    func setupTableView() {
        tableView.register(SearchPageTableViewCell.self)
        tableView.selected = selected
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    func setupSearchBar() {
        searchBar.output = self
    }
    
    func setFloatingButton() {
        floatingButton.addTarget(self, action: #selector(self.upButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(floatingButton)
    }
    
    @objc func upButtonTapped(_ sender: UIButton) {
        tableView.setContentOffset(.zero, animated: true)
        floatingButton.isHidden = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        if currentOffset > 150 {
            floatingButton.isHidden = false
        }
        else {
            floatingButton.isHidden = true
        }
    }
    
    func selected(_ row: Int) {
        guard let detailVc = mainDelegate.mainStoryboard.instantiateViewController(identifier: "DetailPageViewController") as? DetailPageViewController else { return }
        detailVc.viewModel.selectedCity = tableView.cityList?[row].woeid ?? 00
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}


extension SearchPageViewController: CustomSearchBarOutputDelegate {
    
    func changeText(text: String?) {
        if text == "" {
            tableView.cityList = []
        }
        else {
            viewModel.getCityList(cityName: text)
        }
    }
}

extension SearchPageViewController: SearchPageViewModelDelegate {
    
    func getCityList(response: [CityModel]) {
        self.tableView.cityList = response
    }
    
    func changedStatus(status: BaseViewController.RequestStatus) {
        requestStatus = status
        switch status {
            case .completed(let error):
                if error != nil {
                    print("Error")
                }
                else {
                    setups()
                }
            default: break
        }
    }
}






