//
//  CountryViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 26.05.2022.
//

import UIKit

class CountryViewController: UIViewController {
    lazy var countryCard: UIView = {
        let view = CountryCardView(data: (DataManager.currentData?.first)!)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup(){
        view.addSubviews(views: [countryCard])
        
        let countryCardConstraints = Constraints(childView: countryCard, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.5, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 0)
        ])
        countryCardConstraints.addConstraints()
    }
}
