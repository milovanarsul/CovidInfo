//
//  StatisticsViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.05.2022.
//

import UIKit
import BetterSegmentedControl
import CoreData

class StatisticsViewController: UIViewController {
    
    lazy var locationNotSelected: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "locationRestricted")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var date: UILabel = {
        let label = UILabel()
        label.initialize(text: "Astazi, 2 Iunie 2022", color: .black, font: boldFont(size: 20), alignment: .left, lines: 1)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 24
        tableView.clipsToBounds = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.statistics = self
        view.backgroundColor = .clear
        setup()
    }
    
    func setup(){
        /*
        if DataManager.isLocationEnabled() == false {
            view.backgroundColor = .white
            view.addSubview(locationNotSelected)
            
            let locationNotSelectedConstraints = Constraints(childView: locationNotSelected, parentView: view, constraints: [
                Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
                Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
                Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
                Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
            ])
            locationNotSelectedConstraints.addConstraints()
        } else {
            view.backgroundColor = UIColor("#efeff0")
            view.addSubview(pageViewController)
            defaultConstraints(childView: pageViewController, parentView: view)
        }
        */
        
        view.addSubviews(views: [date, tableView])
        
        let dateConstraints = Constraints(childView: date, parentView: view, constraints: [
            Constraint(constraintType: .top, multiplier: 1, constant: 15),
            Constraint(constraintType: .leading, multiplier: 1, constant: 25),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -25),
            Constraint(constraintType: .height, multiplier: 1, constant: 30)
        ])
        dateConstraints.addConstraints()
        
        let tableViewConstraints = Constraints(childView: tableView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        tableViewConstraints.addConstraints()
        tableView.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 10).isActive = true
    }
}

extension StatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 2200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showHistoricData == false {
            let cell = CurrentDataTableViewCell()
            cell.parentViewController = self
            cell.currentData = DataManager.getCurrentCountry(name: "România")
            cell.historicData = DataManager.getHistoricCountry(name: "România")
            cell.setup()
            cell.backgroundColor = UIColor("#efeff0")
            return cell
        } else {
            let cell = HistoricalDataTableViewCell()
            cell.parentViewController = self
            cell.historic2022Data = DataManager.getHistoricCountry(name: "România")
            cell.historic2021Data = DataManager.getHistoric2021Country(name: "România")
            cell.historic2020Data = DataManager.getHistoric2020Country(name: "România")
            cell.setup()
            return cell
        }
    }
}

extension StatisticsViewController: StatisticsViewControllerDelegate {
    func refreshTableView(){
        tableView.reloadData()
    }
}
