//
//  TripPlannerCountryResultView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.05.2022.
//

import Foundation
import UIKit

var expandButtonTapped: Bool = false

class TripPlannerCountryResultView: UITableViewCell {
    var countryTravelData: [CountryTravelModel]?
    var data: CurrentData!
    var type: TripViewType?
    
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
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .green
        return imageView
    }()
    
    lazy var countryName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = true
        return tableView
    }()
    
    lazy var bottomButton: UIButton = {
        let button = UIButton()
        switch expandButtonTapped {
        case false:
            button.initialize(title: "Mai mult", titleColor: signatureDarkBlue, cornerRadius: 0, font: boldFont(size: 14), backgroundColor: .clear, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "arrow.down.circle.fill"))
        case true:
            button.initialize(title: "Mai puțin", titleColor: signatureDarkBlue, cornerRadius: 0, font: boldFont(size: 14), backgroundColor: .clear, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "arrow.up.circle.fill"))
        }
        
        button.addTarget(self, action: #selector(bottomButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    func dataSetup(){
        switch type!{
        case .arrival:
            countryTravelData = AmadeusManager.arrivalCountryTravelData!
            data = DataManager.getCurrentCountry(customLocation: arrivalCountry!.name!)
        case .departure:
            countryTravelData = AmadeusManager.departureCountryTravelData!
            data = DataManager.getCurrentCountry(customLocation: departureCountry!.name!)
        }
    }
    
    func setup(){
        dataSetup()
        contentView.addSubview(parentView)
        
        let parentViewConstraints = Constraints(childView: parentView, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 10)
        ])
        parentViewConstraints.addConstraints()
        
        parentView.addSubview(containerView)
        defaultConstraints(childView: containerView, parentView: parentView)
        
        containerView.addSubviews(views: [countryFlag, countryName, tableView, bottomButton])
        
        countryFlag.image = UIImage(named: (data!.countryISO)!)!
        countryName.initialize(text: roISOCountries[(data!.countryISO)!]!, color: .black, font: boldFont(size: 24), alignment: .left, lines: 0)
        
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
        countryName.topAnchor.constraint(equalTo: countryFlag.bottomAnchor, constant: 100).isActive = true
        
        let tableViewConstraints = Constraints(childView: tableView, parentView: containerView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
        ])
        tableViewConstraints.addConstraints()
        tableView.topAnchor.constraint(equalTo: countryName.bottomAnchor, constant: 0).isActive = true
        
        let bottomButtonConstraints = Constraints(childView: bottomButton, parentView: containerView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 5)
        ])
        bottomButtonConstraints.addConstraints()
        tableView.bottomAnchor.constraint(equalTo: bottomButton.topAnchor, constant: -10).isActive = true
        
        tableView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func bottomButtonTapped(_ sender: UIButton){
        switch expandButtonTapped {
        case false:
            expandButtonTapped = true
        case true:
            expandButtonTapped = false
        }
        delegates.tripPlanner.expandCell(type: type!)
    }
}

extension TripPlannerCountryResultView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryTravelData!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return countryTravelData![indexPath.row].height!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CountryTravelTableViewCell()
        let currentData = countryTravelData![indexPath.row]
        cell.setup(data: currentData, type: .custom)
        cell.selectionStyle = .none
        return cell
    }
}
