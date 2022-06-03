//
//  CountryViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 26.05.2022.
//

import UIKit

class CountryViewController: UIViewController {
    
    var data: CurrentData = DataManager.currentCountryData!
    
    lazy var locationNotSelected: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "locationRestricted")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.register(CountryTravelTableViewCell.self, forCellReuseIdentifier: "countryTravel")
        tableView.register(CountryCardView.self, forCellReuseIdentifier: "countryCardView")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 24
        tableView.clipsToBounds = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.countryController = self
        setup()
    }
    
    func setup(){
        //data = DataManager.currentCountryData
        
        if DataManager.isLocationEnabled() == false{
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
            view.backgroundColor = UIColor("#f2f2f7")
            view.addSubview(tableView)
            defaultConstraints(childView: tableView, parentView: view)
        }
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
        let countryCardCell = tableView.dequeueReusableCell(withIdentifier: "countryCardView") as! CountryCardView
        let countryTravelCell = tableView.dequeueReusableCell(withIdentifier: "countryTravel") as! CountryTravelTableViewCell
        
        if indexPath.row == 0 {
            countryCardCell.data = data
            countryCardCell.setup()
            countryCardCell.backgroundColor = .clear
            return countryCardCell
        } else {
            let currentData = AmadeusManager.currentCountryTravelData![indexPath.row - 1]
            countryTravelCell.backgroundColor = .clear
            countryTravelCell.setup(data: currentData, type: .normal)
            return countryTravelCell
        }
    }
}

extension CountryViewController: CountryViewControllerDelegate {
    func refreshTableView(){
        tableView.reloadData()
    }
}
