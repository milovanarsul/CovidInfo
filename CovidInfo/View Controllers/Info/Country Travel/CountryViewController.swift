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
        
        setup()
    }
    
    func setup(){
        view.backgroundColor = UIColor("#f2f2f7")
        view.addSubviews(views: [tableView])
        defaultConstraints(childView: tableView, parentView: view)
    }
}

extension CountryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AmadeusManager.countryTravelData!.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat?
        
        if indexPath.row == 0{
            height = 400
        } else {
            height = AmadeusManager.countryTravelData![indexPath.row - 1].height
        }
        
        return height!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countryCardCell = tableView.dequeueReusableCell(withIdentifier: "countryCardView") as! CountryCardView
        let countryTravelCell = tableView.dequeueReusableCell(withIdentifier: "countryTravel") as! CountryTravelTableViewCell
        
        if indexPath.row == 0 {
            countryCardCell.setup()
            countryCardCell.backgroundColor = .clear
            return countryCardCell
        } else {
            let currentData = AmadeusManager.countryTravelData![indexPath.row - 1]
            countryTravelCell.data = currentData
            countryTravelCell.backgroundColor = .clear
            return countryTravelCell
        }
    }
}
