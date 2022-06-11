//
//  CompareCountriesResultView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 03.06.2022.
//

import UIKit

class CompareCountriesResultTableViewCell: UITableViewCell {
    var data: CurrentData!
    var parentViewController: UIViewController!
    var statisticsResumeData: [(String, String)]?
    
    lazy var country: UIView = {
        lazy var flagImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: data.countryISO!)!
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
        
        lazy var countryName: UILabel = {
            let label = UILabel()
            label.initialize(text: data.location!, color: .black, font: boldFont(size: 20), alignment: .left, lines: 0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        
        view.addSubviews(views: [flagImageView, countryName])
        
        let flagimageViewConstraints = Constraints(childView: flagImageView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.8, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 0)
        ])
        flagimageViewConstraints.addConstraints()
        
        countryName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        countryName.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 5).isActive = true
        
        return view
    }()
    
    lazy var charts: UIView = {
        let view = UIView()
        parentViewController.addSubSwiftUIView(AllHistoricData(countryCompare: CountryCompare(currentCountry: data!)), to: view)
        return view
    }()
    
    lazy var resumeTableView: UITableView = {
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
        statisticsResumeData = DataManager.dataResume(currentData: data!)
        contentView.addSubviews(views: [country, charts, resumeTableView])
        
        let countryConstraints = Constraints(childView: country, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.07, constant: 0)
        ])
        countryConstraints.addConstraints()
        
        let chartsConstraints = Constraints(childView: charts, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        chartsConstraints.addConstraints()
        charts.topAnchor.constraint(equalTo: country.bottomAnchor, constant: 10).isActive = true
        
        let resumeTableViewConstraints = Constraints(childView: resumeTableView, parentView: contentView, constraints: [
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 14),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -14),
            Constraint(constraintType: .height, multiplier: 1, constant: CGFloat(statisticsResumeData!.count * 75 + statisticsResumeData!.count * 5))
        ])
        resumeTableViewConstraints.addConstraints()
    }
}

extension CompareCountriesResultTableViewCell: UITableViewDelegate, UITableViewDataSource{
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
