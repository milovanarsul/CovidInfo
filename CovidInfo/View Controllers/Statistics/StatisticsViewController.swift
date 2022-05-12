//
//  StatisticsViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.05.2022.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    var currentData: [Dictionary<String, CurrentData>.Element]?
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var countryCard: UIView = {
        let data = currentData?.first
        let view = CountryCardView(isoCountry: data!.key, data: data!.value)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.statistics = self
        currentData = parseCurrentData()
        setup()
    }
    
    func setup(){
        view.addSubview(contentView)
        defaultConstraints(childView: contentView, parentView: view)
        
        contentView.addSubview(countryCard)
        
        let countryCardConstraints = Constraints(childView: countryCard, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.95, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.45, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 20)
        ])
        countryCardConstraints.addConstraints()
    }
}

extension StatisticsViewController: StatisticsViewControllerDelegate {
    func contentViewVisibility(visibility: Bool){
        contentView.isHidden = visibility
    }
}
