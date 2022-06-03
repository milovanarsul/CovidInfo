//
//  CompareCountriesResultView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 03.06.2022.
//

import UIKit

class CompareCountriesResultViewController: UIViewController {
    var data: CurrentData!
    var statisticsResumeData: [(String, String)]?
    
    lazy var parentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var countryFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: (data!.countryISO)!)!
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .green
        return imageView
    }()
    
    lazy var countryName: UILabel = {
        let label = UILabel()
        label.initialize(text: roISOCountries[(data!.countryISO)!]!, color: .black, font: boldFont(size: 24), alignment: .left, lines: 0)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .gray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        tableView.register(StatisticsResumeTableViewCell.self, forCellReuseIdentifier: "statisticsResumeResult")
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 12
        tableView.clipsToBounds = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statisticsResumeData = DataManager.dataResume(currentData: data!)
        setup()
    }
    
    func setup(){
        view.addSubview(parentView)
        
        let parentViewConstraints = Constraints(childView: parentView, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 10)
        ])
        parentViewConstraints.addConstraints()
        
        parentView.addSubview(containerView)
        defaultConstraints(childView: containerView, parentView: parentView)
        
        containerView.addSubviews(views: [countryFlag, countryName, tableView])
        
        let countryFlagConstraints = Constraints(childView: countryFlag, parentView: containerView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 60),
            Constraint(constraintType: .top, multiplier: 1, constant: 0)
        ])
        countryFlagConstraints.addConstraints()
        
        let countryNameConstraints = Constraints(childView: countryName, parentView: containerView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 20)
        ])
        countryNameConstraints.addConstraints()
        countryName.topAnchor.constraint(equalTo: countryFlag.bottomAnchor, constant: 110).isActive = true
        
        let tableViewConstraints = Constraints(childView: tableView, parentView: containerView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        tableViewConstraints.addConstraints()
        tableView.topAnchor.constraint(equalTo: countryName.bottomAnchor, constant: 0).isActive = true
    }
    
    init(data: CurrentData){
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
}

extension CompareCountriesResultViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statisticsResumeData!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statisticsResumeResult") as! StatisticsResumeTableViewCell
        cell.titleText = statisticsResumeData![indexPath.row].0
        cell.subtitleText = statisticsResumeData![indexPath.row].1
        cell.setup()
        cell.backgroundColor = .clear
        return cell
    }
}
