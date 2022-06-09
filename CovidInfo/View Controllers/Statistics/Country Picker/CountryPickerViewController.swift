//
//  CountryPickerViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.05.2022.
//

import UIKit
import CoreLocation

class CountryPickerViewController: UIViewController {
    
    var currentData: CurrentData?
    
    lazy var locationPickerView: UIView = {
        let location = AppDelegate.locationCountry
        let view: UIView?
        if let location = location {
            view = LocationPickerView(location: AppDelegate.locationCountry!)
        } else {
            view = LocationPickerView(location: "")
        }
        return view!
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
        tableView.separatorInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "countryCell")
        tableView.register(CountryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "countryTableViewHeader")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 4
        return tableView
    }()
    
    var data: [String: [Country]] = countryModelData()
    var formatedData: [String: [Country]]!
    var sections = ["Alege o tara"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setup()
        formatedData = data
    }
    
    var currentCountry: UIView?
    
    func setup(){
        
        view.addSubviews(views: [searchBar, tableView])
        
        let searchBarConstraints = Constraints(childView: searchBar, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.9, constant: 0),
        ])
        searchBarConstraints.addConstraints()
        
        if defaults.bool(forKey: "locationPermissionDenied") == false{
            view.addSubview(locationPickerView)
            let locationPickerViewConstraints = Constraints(childView: locationPickerView, parentView: view, constraints: [
                Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
                Constraint(constraintType: .proportionalWidth, multiplier: 0.9, constant: 0),
                Constraint(constraintType: .height, multiplier: 1, constant: 50),
            ])
            locationPickerViewConstraints.addConstraints()
            locationPickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
            
            NSLayoutConstraint.activate([searchBar.topAnchor.constraint(equalTo: locationPickerView.bottomAnchor, constant: -10)])
        } else {
            NSLayoutConstraint.activate([searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 5)])
        }
        
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
    }
}

extension CountryPickerViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            formatedData = data
        } else {
            let searchableSection = "Alege o tara"
            formatedData[searchableSection] = data[searchableSection]!.filter {(countryData: Country) -> Bool in
                return countryData.name!.lowercased().contains(searchText.lowercased())
            }
        }

        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        formatedData = data
    }
}

var auxManualLocation: String?

extension CountryPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return formatedData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentSection = sections[section]
        return formatedData[currentSection]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell
        let currentSection = sections[indexPath.section]
        let currentCountry = formatedData[currentSection]
        cell.country = currentCountry![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "countryTableViewHeader") as! CountryTableViewHeader
        view.title = sections[section]
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionTitle = "Tara aleasa"
        
        let currentSection = sections[indexPath.section]
        let currentCountry = formatedData[currentSection]
        formatedData[sectionTitle] = [currentCountry![indexPath.row]]
        
        if sections[0] == sectionTitle{
            sections.remove(at: 0)
        }
        sections.insert(sectionTitle, at: 0)
        
        auxManualLocation = currentCountry![indexPath.row].name!
        
        let top = CGPoint(x: 0, y: -tableView.contentInset.top)
        tableView.setContentOffset(top, animated: true)
        tableView.reloadData()
        
        delegates.main.countryPickerActionsAnimaiton(visibility: .show)
    }
}
