//
//  TripPlannerCountryPickerView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.05.2022.
//

import UIKit

var departureCountry: Country?
var arrivalCountry: Country?

class TripPlannerCountryPickerTableView: UIView {
    
    var viewType: TripViewType?
    
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
        case .arrival:
            title = "Selectează o destinație"
        case .departure:
            title = "Selectează o locație de plecare"
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
        searchBar.showsCancelButton = true
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
        tableView.register(CountryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "countryTableViewHeader")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 4
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    var data: [Country] = simpleCountryData()
    var formatedData: [Country]!
    
    init(viewType: TripViewType){
        self.viewType = viewType
        super.init(frame: .zero)
        
        tableViewData()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func tableViewData(){
        var indexToBeDeleted: Int?
        
        if departureCountry != nil {
            for index in 0..<data.count {
                if data[index].name == departureCountry?.name {
                    indexToBeDeleted = index
                }
            }
            
            data.remove(at: indexToBeDeleted!)
        }
        
        formatedData = data
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
        case .arrival:
            delegates.tripPlanner.animateArrivalView()
        case .departure:
            delegates.tripPlanner.animateDepartureView()
        case .none: ()
        }
    }
}

extension TripPlannerCountryPickerTableView: UISearchBarDelegate{
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

extension TripPlannerCountryPickerTableView: UITableViewDelegate, UITableViewDataSource {
    
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
        searchBar.endEditing(true)
        switch viewType{
        case .departure:
            departureCountry = formatedData[indexPath.row]
        case .arrival:
            arrivalCountry = formatedData[indexPath.row]
        case .none:
            ()
        }
        
        closeButtonTapped()
        tableView.deselectRow(at: indexPath, animated: false)
        
        if departureCountry != nil && arrivalCountry != nil{
            delegates.tripPlanner.result()
        }
    }
}
