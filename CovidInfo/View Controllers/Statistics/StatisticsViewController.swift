//
//  StatisticsViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.05.2022.
//

import UIKit
import BetterSegmentedControl

class StatisticsViewController: UIViewController {
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
        let countryCompare = CountryCompare(currentCountry: DataManager.currentCountryData!)
        let statisticsResumeData = DataManager.dataResume(currentData: DataManager.currentCountryData!)
        
        return CGFloat(countryCompare.visibleCellsCount * 470) + CGFloat(statisticsResumeData.count * 75 + statisticsResumeData.count * 5) + 820
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CurrentDataTableViewCell()
        cell.parentViewController = self
        cell.currentData = DataManager.currentCountryData!
        cell.historicData = DataManager.historicCountryData!
        cell.setup()
        cell.backgroundColor = UIColor("#efeff0")
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 50 {
            delegates.main.tabBarScrollAnimation(visibility: .hide)
        } else {
            delegates.main.tabBarScrollAnimation(visibility: .show)
        }
        
        if scrollView.contentOffset.y > 797{
            updateDate(text: "De la inceputul pandemiei")
        } else {
            let date = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            let month = romanianMonths[date.month!]
            updateDate(text: "Astazi, \(date.day!) \(month!) \(date.year!)")
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
    
    func scrollToTop(){
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func historicData(){
        if showHistoricData{
            tableView.isHidden = true
            let historicalDataView = HistoricalDataView(historic2022Data: DataManager.historicCountryData!, historic2021Data: DataManager.currentHistoric2021Data!, historic2020Data: DataManager.currentHistoric2020Data!, parentViewController: self)
            historicalDataView.tag = 8
            view.addSubview(historicalDataView)
            
            let historicalDataViewConstraints = Constraints(childView: historicalDataView, parentView: view, constraints: [
                Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
                Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
                Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
            ])
            historicalDataViewConstraints.addConstraints()
            historicalDataView.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 10).isActive = true
        } else {
            view.viewWithTag(8)?.removeFromSuperview()
            tableView.isHidden = false
        }
    }
}
