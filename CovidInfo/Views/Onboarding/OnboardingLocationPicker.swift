//
//  OnboardingLocationPicker.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 07.06.2022.
//

import UIKit

var onboardingManualCountry: Country?

class OnboardingLocationPicker: UIViewController {
    
    lazy var locationPickerView: UIView = {
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
            let label = UILabel()
            label.initialize(text: "Selecteaza o locatie", color: .black, font: boldFont(size: 18), alignment: .left, lines: 1)
            return label
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
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
            tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "countryCell")
            tableView.register(CountryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "countryTableViewHeader")
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.layer.cornerRadius = 4
            tableView.tag = 3
            return tableView
        }()
        
        let view = UIView()
        view.addSubview(parentView)
        
        let parentViewConstraints = Constraints(childView: parentView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 20)
        ])
        parentViewConstraints.addConstraints()
        
        parentView.addSubviews(views: [shadowView, containerView])
        defaultAnchors(childView: shadowView, parentView: parentView)
        defaultConstraints(childView: containerView, parentView: parentView)
        
        containerView.addSubviews(views: [titleLabel, tableView, searchBar])
        
        let titleLabelConstraints = Constraints(childView: titleLabel, parentView: containerView, constraints: [
            Constraint(constraintType: .top, multiplier: 1, constant: 20),
            Constraint(constraintType: .leading, multiplier: 1, constant: 24)
        ])
        titleLabelConstraints.addConstraints()
        
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
        
        
        return view
    }()
    
    lazy var resultView: UIView = {
        lazy var countryFlag: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: (onboardingManualCountry?.image)!)!
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 50
            imageView.clipsToBounds = true
            return imageView
        }()
        
        lazy var countryName: UILabel = {
            let label = UILabel()
            label.initialize(text: (onboardingManualCountry?.name!)!, color: .black, font: boldFont(size: 25), alignment: .center, lines: 0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        lazy var buttonStack: UIStackView = {
            lazy var editButton: UIButton = {
                let button = UIButton()
                button.initialize(title: "Schimba locatia", titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                button.addTarget(self, action: #selector(editLocationTapped), for: .touchUpInside)
                return button
            }()
            
            lazy var skipButton: UIButton = {
                let button = UIButton()
                button.initialize(title: "Mai departe", titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: greenColor, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
                return button
            }()
            
            let stackView = UIStackView()
            stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 18)
            stackView.addAranagedSubviews(views: [editButton, skipButton])
            stackView.tag = 1
            return stackView
        }()
        
        let view = UIView()
        view.addSubviews(views: [countryFlag, countryName,buttonStack])
        
        let countryFlagConstraints = Constraints(childView: countryFlag, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 100),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
        ])
        countryFlagConstraints.addConstraints()
        
        countryName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        countryName.topAnchor.constraint(equalTo: countryFlag.bottomAnchor, constant: 30).isActive = true
        
        let buttonStackConstraints = Constraints(childView: buttonStack, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.5, constant: 0),
        ])
        buttonStackConstraints.addConstraints()
        buttonStack.topAnchor.constraint(equalTo: countryName.bottomAnchor, constant: 50).isActive = true
        
        return view
    }()
    
    var data: [Country] = simpleCountryData()
    var formatedData: [Country]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.onboarding.pageControlVisibility(visibility: true)
        formatedData = data
        setup()
    }
    
    var locationPickerBottomConstraint = NSLayoutConstraint()
    
    func setup(){
        view.addSubview(locationPickerView)
        
        let locationPickerViewConstraints = Constraints(childView: locationPickerView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.95, constant: 0)
        ])
        locationPickerViewConstraints.addConstraints()
        locationPickerBottomConstraint = locationPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        locationPickerBottomConstraint.isActive = true
    }
    
    func animateLocationPicker(visibilty: ViewVisibility){
        switch visibilty {
        case .show:
            self.resultView.removeFromSuperview()
            delegates.onboarding.pageControlVisibility(visibility: true)
            locationPickerBottomConstraint.constant = 0
        case .hide:
            locationPickerBottomConstraint.constant = 1000
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            self.locationPickerView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            switch visibilty {
            case .show:
                ()
            case .hide:
                self.locationPickerResult()
                delegates.onboarding.pageControlVisibility(visibility: false)
            }
        })
    }
    
    func locationPickerResult(){
        view.addSubview(resultView)
        defaultConstraints(childView: resultView, parentView: view)
    }
    
    @objc func editLocationTapped(){
        animateLocationPicker(visibilty: .show)
    }
    
    @objc func nextButtonTapped(){
        defaults.setValue(onboardingManualCountry?.name, forKey: "manualCountry")
        defaults.set(false, forKey: "useAutomaticLocation")
        locationPickerView.removeFromSuperview()
        resultView.removeFromSuperview()
        delegates.onboarding.downloadData(dataRequest: .all)
    }
}

extension OnboardingLocationPicker: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            formatedData = data
        } else {
            formatedData = data.filter {(countryData: Country) -> Bool in
                return countryData.name!.lowercased().contains(searchText.lowercased())
            }
        }

        (locationPickerView.viewWithTag(3) as! UITableView).reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        formatedData = data
    }
}

extension OnboardingLocationPicker: UITableViewDelegate, UITableViewDataSource {
    
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
        onboardingManualCountry = formatedData[indexPath.row]
        animateLocationPicker(visibilty: .hide)
    }
}
