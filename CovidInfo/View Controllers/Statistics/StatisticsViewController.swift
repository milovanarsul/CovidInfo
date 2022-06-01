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
    
    lazy var locationNotSelected: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "locationRestricted")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor("#efeff0")
        delegates.statistics = self
        setup()
    }
    
    func setup(){
        let automaticCountry: Bool = (AppDelegate.locationCountry != nil)
        let manualCountry: Bool = (defaults.string(forKey: "manualCountry") != nil)
        
        if automaticCountry == false && manualCountry == false{
            view.backgroundColor = .white
            view.addSubview(locationNotSelected)
            
            let locationNotSelectedConstraints = Constraints(childView: locationNotSelected, parentView: view, constraints: [
                Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
                Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
                Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
                Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
            ])
            locationNotSelectedConstraints.addConstraints()
        }
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0.0
    }
}
