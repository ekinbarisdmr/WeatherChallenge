//
//  DetailPageeViewController.swift
//  AppcentWeatherApp
//
//  Created by Ekin Barış Demir on 4.09.2021.
//

import UIKit

class DetailPageViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var viewModel: DetailPageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        requestStatus = .pending
        viewModel.delegate = self
        checkInternet()
        
    }
    
    func setups() {
        setNavigationBar()
        setupTableView()
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "\(viewModel.weatherDetails.title ?? "") Weathers"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: viewModel, action: #selector(viewModel.saveCity(sender:)))
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.setStatusBar(backgroundColor: .clear)
        definesPresentationContext = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationItem.backBarButtonItem = backButton
        
    }
    
    func checkInternet() {
        if CheckInternet.Connection() {
            viewModel.fetchWeatherDetail()
        }
        else {
            Alert.showAlert(viewController: self, title: internetErrorTitle, message: internetErrorMessage)
        }
    }
    
    func setupTableView() {
        tableView.register(DetailPageTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.reloadData()
    }
}

//MARK: UITableViewDataSource

extension DetailPageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(DetailPageTableViewCell.self)!
            cell.backgroundColor = UIColor.detailBgColor()
            DispatchQueue.main.async { [self] in
                cell.configure(viewModel.details[indexPath.row])
                cell.dayLabel.text = viewModel.datesArray[indexPath.row]
            }
            return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView()
        headerView.configure(viewModel.weatherDetails)
        return headerView
    }
}

//MARK: UITableViewDelegate

extension DetailPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 400
    }
}

extension DetailPageViewController: DetailPageViewModelDelegate {
    
    func savedCity(result: Bool) {
        if result {
            Alert.showAlert(viewController: self, title: savedCityTitle, message: savedCityMessage)
            
        }
        else {
            view.shake()
            Alert.showAlert(viewController: self, title: savedCityErrorTitle, message: savedCityErrorMessage)
        }
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
            case .unknown:
                Alert.showAlert(viewController: self, title: internetErrorTitle, message: internetErrorMessage)
            default: break
        }
    }
}



