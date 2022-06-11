//
//  CurrentDataTableViewCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 02.06.2022.
//

import UIKit

class CurrentDataTableViewCell: UITableViewCell {
    
    @Published var currentData: CurrentData?
    @Published var historicData: HistoricalData?
    
    var parentViewController: UIViewController?
    var statisticsResumeData: [(String, String)]?
    
    lazy var casesAndDeaths: UIView = {
        let view = UIView()
        parentViewController!.addSubSwiftUIView(CasesAndDeaths(currentData: currentData!, historicData: historicData!), to: view)
        return view
    }()
    
    lazy var sevenDaysCharts: UIView = {
        let view = UIView()
        parentViewController!.addSubSwiftUIView(SevenDaysCharts(currentData: currentData!, historicData: historicData!), to: view)
        return view
    }()
    
    lazy var statisticsResume: UIView = {
        
        lazy var label: UILabel = {
            let label = UILabel()
            label.initialize(text: "De la inceputul pandemiei", color: .black, font: boldFont(size: 16), alignment: .left, lines: 0)
            return label
        }()

        lazy var allHistoricData: UIView = {
            let view = UIView()
            parentViewController?.addSubSwiftUIView(AllHistoricData(countryCompare: CountryCompare(currentCountry: currentData!)), to: view)
            return view
        }()
        
        let view = UIView()
        view.addSubviews(views: [label, allHistoricData])
        
        let labelConstraints = Constraints(childView: label, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .top, multiplier: 1, constant: 5)
        ])
        labelConstraints.addConstraints()
        
        let tableViewConstraints = Constraints(childView: allHistoricData, parentView: view, constraints: [
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0),
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0)
        ])
        tableViewConstraints.addConstraints()
        allHistoricData.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .gray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        tableView.register(StatisticsResumeTableViewCell.self, forCellReuseIdentifier: "statisticsResume")
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 12
        tableView.clipsToBounds = true
        return tableView
    }()
    
    func setup(){
        statisticsResumeData = DataManager.dataResume(currentData: currentData!)
        contentView.addSubviews(views: [casesAndDeaths, sevenDaysCharts, statisticsResume, tableView])
        
        let casesAndDeathsConstraints = Constraints(childView: casesAndDeaths, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .height, multiplier: 1, constant: 250)
        ])
        casesAndDeathsConstraints.addConstraints()
        
        let sevenDaysChartsConstraints = Constraints(childView: sevenDaysCharts, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 490)
        ])
        sevenDaysChartsConstraints.addConstraints()
        sevenDaysCharts.topAnchor.constraint(equalTo: casesAndDeaths.bottomAnchor, constant: 20).isActive = true
        
        let statisticsResumeConstraints = Constraints(childView: statisticsResume, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 0),
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        statisticsResumeConstraints.addConstraints()
        statisticsResume.topAnchor.constraint(equalTo: sevenDaysCharts.bottomAnchor, constant: 2).isActive = true
        
        let tableViewConstraints = Constraints(childView: tableView, parentView: contentView, constraints: [
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .height, multiplier: 1, constant: CGFloat(statisticsResumeData!.count * 75 + statisticsResumeData!.count * 5))
        ])
        tableViewConstraints.addConstraints()
    }
}

extension CurrentDataTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statisticsResumeData!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statisticsResume") as! StatisticsResumeTableViewCell
        cell.titleText = statisticsResumeData![indexPath.row].0
        cell.subtitleText = statisticsResumeData![indexPath.row].1
        cell.setup()
        cell.backgroundColor = .clear
        return cell
    }
}
