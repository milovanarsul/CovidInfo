//
//  CountryViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 26.05.2022.
//

import UIKit

class CountryViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 24
        tableView.clipsToBounds = true
        tableView.tag = 1
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.countryController = self
        setup()
    }
    
    func setup(){
        view.backgroundColor = UIColor("#f2f2f7")
        view.addSubview(tableView)
        defaultConstraints(childView: tableView, parentView: view)
    }
}

extension CountryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AmadeusManager.currentCountryTravelData!.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat?
        
        if indexPath.row == 0{
            height = 400
        } else {
            height = AmadeusManager.currentCountryTravelData![indexPath.row - 1].height
        }
        
        return height!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countryCardCell = CountryCardView()
        let countryTravelCell = CountryTravelTableViewCell()
        
        if indexPath.row == 0 {
            countryCardCell.data = DataManager.currentCountryData!
            countryCardCell.setup()
            countryCardCell.backgroundColor = .clear
            countryCardCell.selectionStyle = .none
            return countryCardCell
        } else {
            let currentData = AmadeusManager.currentCountryTravelData![indexPath.row - 1]
            countryTravelCell.backgroundColor = .clear
            countryTravelCell.setup(data: currentData, type: .normal)
            countryTravelCell.selectionStyle = .none
            return countryTravelCell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 50 {
            delegates.main.tabBarScrollAnimation(visibility: .hide)
        } else {
            delegates.main.tabBarScrollAnimation(visibility: .show)
        }
    }
}

extension CountryViewController: CountryViewControllerDelegate {
    func refreshTableView(){
        tableView.reloadData()
    }
    
    func scrollToTop(){
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}
