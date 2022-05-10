//
//  CountryPickerViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.05.2022.
//

import UIKit

class CountryPickerViewController: UIViewController {
    
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
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "countryCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var data: [CountryModel] {
        var countryData = [CountryModel]()
        
        for(key, value) in isoCountries{
            countryData.append(CountryModel(image: key, name: value))
        }
        
        return countryData.sorted {$0.name! < $1.name!}
    }
    var formatedData: [CountryModel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        formatedData = data
    }
    
    func setup(){
        view.addSubviews(views: [tableView, searchBar])
        
        let searchBarConstraints = Constraints(childView: searchBar, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .height, multiplier: 1, constant: 44)
        ])
        searchBarConstraints.addConstraints()
        
        let tableViewConstraints = Constraints(childView: tableView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.9, constant: 0)
        ])
        tableViewConstraints.addConstraints()
    }
}

extension CountryPickerViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            formatedData = data
        } else {
            formatedData = data.filter { (countryData: CountryModel) -> Bool in
                return countryData.name!.lowercased().contains(searchText.lowercased())
            }
        }
        
        tableView.reloadData()
    }
}

extension CountryPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        formatedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell
        cell.country = formatedData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
