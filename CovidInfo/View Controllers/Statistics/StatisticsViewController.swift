//
//  StatisticsViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.05.2022.
//

import UIKit
import CoreData

class StatisticsViewController: UIViewController {
    
    var countryData: [CountryData]?
    
    lazy var locationNotSelected: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "locationRestricted")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var countryCard: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        delegates.statistics = self
        setup()
    }
    
    func fetchData(){
        let request = CountryData.fetchRequest() as NSFetchRequest<CountryData>
        
        do {
            self.countryData = try AppDelegate.context.fetch(request)
        } catch {
            fatalError()
        }
    }
    
    func setup(){
        
        let automaticCountry: Bool = (AppDelegate.locationCountry != nil)
        let manualCountry: Bool = (defaults.string(forKey: "manualCountry") != nil)
        
        if automaticCountry == false && manualCountry == false{
            view.addSubview(locationNotSelected)
            
            let locationNotSelectedConstraints = Constraints(childView: locationNotSelected, parentView: view, constraints: [
                Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
                Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
                Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
                Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
            ])
            locationNotSelectedConstraints.addConstraints()
        }
        
        if automaticCountry || manualCountry{
            
            let currentLocation = defaults.bool(forKey: "automaticLocation") ? getCountry(name: AppDelegate.locationCountry!): getCountry(name: defaults.string(forKey: "manualCountry")!)
            countryCard = CountryCardView(data: currentLocation)
            view.addSubview(countryCard!)
            
            let countryCardConstraints = Constraints(childView: countryCard!, parentView: view, constraints: [
                Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
                Constraint(constraintType: .proportionalWidth, multiplier: 0.95, constant: 0),
                Constraint(constraintType: .height, multiplier: 1, constant: 400),
                Constraint(constraintType: .top, multiplier: 1, constant: 5)
            ])
            countryCardConstraints.addConstraints()
        }
    }
    
    func getCountry(name: String) -> CountryData{
        var currentCountry: CountryData?
        
        for country in countryData! {
            if country.location == name{
                currentCountry = country
            }
        }
        
        return currentCountry!
    }
}

extension StatisticsViewController: StatisticsViewControllerDelegate {
    
    func setupCountry(){
        
        if locationNotSelected.isDescendant(of: view){
            locationNotSelected.removeFromSuperview()
        }
        
        if let cCard = countryCard {
            cCard.removeFromSuperview()
            cCard.layoutIfNeeded()
        }
        
        setup()
    }
    
    func contentViewVisibility(visibility: Bool){
        locationNotSelected.isHidden = visibility
        
        if let cCard = countryCard {
            cCard.isHidden = visibility
        }
    }
}
