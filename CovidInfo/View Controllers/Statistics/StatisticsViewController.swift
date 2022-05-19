//
//  StatisticsViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.05.2022.
//

import UIKit
import BetterSegmentedControl
import CoreData

class StatisticsViewController: UIViewController {
    
    var currentData: CurrentData?
    var historicData: HistoricData?
    
    lazy var locationNotSelected: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "locationRestricted")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var categories: BetterSegmentedControl = {
        let regularFont = UIFont(name: "IBMPLexSans-Regular", size: 14)!
        let categories = BetterSegmentedControl(frame: .zero, segments: LabelSegment.segments(withTitles: ["Astazi", "Vaccinare", "Variante"], normalFont: regularFont, normalTextColor: .black, selectedFont: regularFont ,selectedTextColor: .white), options: [.backgroundColor(.white), .indicatorViewBackgroundColor(.black), .cornerRadius(16), .animationSpringDamping(1.0)])
        //categories.addTarget(self, action: #selector(categoriesTapped(_:)), for: .valueChanged)
        return categories
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var firstViewController: UIView = {
        let view = FirstCategory(parentViewController: self, currentData: currentData!, historicData: historicData!)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.statistics = self
        setup()
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
            currentData = defaults.bool(forKey: "automaticLocation") ? delegates.launch.getCurrentCountry(name: AppDelegate.locationCountry!): delegates.launch.getCurrentCountry(name: defaults.string(forKey: "manualCountry")!)
            historicData = defaults.bool(forKey: "automaticLocation") ? delegates.launch.getHistoricCountry(name: AppDelegate.locationCountry!): delegates.launch.getHistoricCountry(name: defaults.string(forKey: "manualCountry")!)
            
            contentSetup()
        }
    }
    
    func contentSetup(){
        view.addSubviews(views: [categories, contentView])
        
        let categoriesConstraints = Constraints(childView: categories, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .height, multiplier: 1, constant: 30)
        ])
        categoriesConstraints.addConstraints()
        
        let contentViewConstraints = Constraints(childView: contentView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        contentViewConstraints.addConstraints()
        contentView.topAnchor.constraint(equalTo: categories.bottomAnchor, constant: 10).isActive = true
        
        contentView.addSubviews(views: [firstViewController])
        defaultConstraints(childView: firstViewController, parentView: contentView)
    }
}

extension StatisticsViewController: StatisticsViewControllerDelegate {
    func setupCountry(){
        if locationNotSelected.isDescendant(of: view){
            locationNotSelected.removeFromSuperview()
        }
        
        setup()
    }
    
    func contentViewVisibility(visibility: Bool){
        locationNotSelected.isHidden = visibility
    }
}

extension StatisticsViewController: UIScrollViewDelegate{
    
}
