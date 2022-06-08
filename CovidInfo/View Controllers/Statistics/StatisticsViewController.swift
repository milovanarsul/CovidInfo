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
        let date = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let month = romanianMonths[date.month!]
        label.initialize(text: "Astazi, \(date.day!) \(month!) \(date.year!)", color: .black, font: boldFont(size: 20), alignment: .left, lines: 1)
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
            cell.currentData = DataManager.currentCountryData!
            cell.historicData = DataManager.historicCountryData!
            cell.setup()
            cell.backgroundColor = UIColor("#efeff0")
            return cell
        } else {
            let cell = HistoricalDataTableViewCell()
            cell.parentViewController = self
            cell.historic2022Data = DataManager.historicCountryData!
            cell.historic2021Data = DataManager.currentHistoric2021Data!
            cell.historic2020Data = DataManager.currentHistoric2020Data!
            cell.setup()
            cell.backgroundColor = UIColor("#efeff0")
            return cell
        }
    }
}

extension StatisticsViewController: StatisticsViewControllerDelegate {
    func refreshTableView(){
        tableView.reloadData()
    }
    
    func updateDate(text: String){
        date.initialize(text: text, color: .black, font: boldFont(size: 20), alignment: .left, lines: 1)
    }
}
