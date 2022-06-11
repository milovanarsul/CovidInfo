//
//  CompareCountriesPickerView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 03.06.2022.
//

import UIKit

var country1: Country?
var country2: Country?

class CompareCountriesPickerView: UIView {
    var viewType: CountryCompareType?
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 100
        view.layer.shadowOffset = CGSize(width: -1, height: 2)
        return view
    }()
    
    lazy var parentView: UIView = {
        let view = UIView()
        return view
    }()
        
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.20)
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        var title: String?
        switch viewType{
        case .country1:
            title = "Selecteaza tara 1"
        case .country2:
            title = "Selecteaza tara 2"
        case .none:
            ()
        }
        
        let label = UILabel()
        label.initialize(text: title!, color: .black, font: boldFont(size: 18), alignment: .left, lines: 1)
        return label
    }()
    
    lazy var closeButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "darkOnLight")!
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.showsCancelButton = true
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
        tableView.register(CountryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "countryTableViewHeader")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 4
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    var data: [Country] = simpleCountryData()
    var formatedData: [Country]!
    
    init(viewType: CountryCompareType){
        self.viewType = viewType
        super.init(frame: .zero)
        
        formatedData = data
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func setup(){
        addSubview(parentView)
                
        let parentViewConstraints = Constraints(childView: parentView, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 20)
        ])
        parentViewConstraints.addConstraints()
        
        parentView.addSubviews(views: [shadowView, containerView])
        defaultAnchors(childView: shadowView, parentView: parentView)
        defaultConstraints(childView: containerView, parentView: parentView)
        
        containerView.addSubviews(views: [titleLabel, closeButton, tableView, searchBar])
        
        let titleLabelConstraints = Constraints(childView: titleLabel, parentView: containerView, constraints: [
            Constraint(constraintType: .top, multiplier: 1, constant: 20),
            Constraint(constraintType: .leading, multiplier: 1, constant: 24)
        ])
        titleLabelConstraints.addConstraints()
        
        let closeButtonConstraints = Constraints(childView: closeButton, parentView: containerView, constraints: [
            Constraint(constraintType: .trailing, multiplier: 1, constant: -24),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 25)
        ])
        closeButtonConstraints.addConstraints()
        closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        
        let searchBarConstraints = Constraints(childView: searchBar, parentView: containerView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .height, multiplier: 1, constant: 44)
        ])
        searchBarConstraints.addConstraints()
        searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        
        let tableViewConstraints = Constraints(childView: tableView, parentView: containerView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0),
        ])
        tableViewConstraints.addConstraints()
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc func closeButtonTapped(){
        searchBar.endEditing(true)
        switch viewType{
        case .country2:
            delegates.compareCountries.animateCountry2()
        case .country1:
            delegates.compareCountries.animateCountry1()
        case .none: ()
        }
    }
}

extension CompareCountriesPickerView: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            formatedData = data
        } else {
            formatedData = data.filter {(countryData: Country) -> Bool in
                return countryData.name!.lowercased().contains(searchText.lowercased())
            }
        }

        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        formatedData = data
    }
}

extension CompareCountriesPickerView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formatedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell
        cell.country = formatedData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewType{
        case .country1:
            country1 = formatedData[indexPath.row]
        case .country2:
            country2 = formatedData[indexPath.row]
        case .none:
            ()
        }
        
        searchBar.endEditing(true)
        closeButtonTapped()
        tableView.deselectRow(at: indexPath, animated: false)
        
        if country1 != nil && country2 != nil{
            delegates.compareCountries.result()
        }
    }
}
