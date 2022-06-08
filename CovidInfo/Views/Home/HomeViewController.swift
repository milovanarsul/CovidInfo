//
//  HomeViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.03.2022.
//

import Foundation
import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    @Published var currentData: CurrentData? = DataManager.currentCountryData!
    @Published var historicData: HistoricalData? = DataManager.historicCountryData!
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(HomeViewTableViewCell.self, forCellReuseIdentifier: "homeViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 24
        tableView.clipsToBounds = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.home = self
        setup()
    }
    
    func setup(){
        view.addSubview(tableView)
        view.backgroundColor = UIColor("#f2f2f7")
        defaultConstraints(childView: tableView, parentView: view)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeViewCell") as! HomeViewTableViewCell
        cell.currentData = currentData
        cell.historicData = historicData
        cell.parentViewController = self
        cell.setup()
        return cell
    }
}

extension HomeViewController: HomeViewControllerDelegate{
    func refreshTableView(){
        tableView.reloadData()
    }
}


