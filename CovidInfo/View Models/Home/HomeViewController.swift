//
//  HomeViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.03.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        CovidInfo.embed.headerPageViewController(parent: self, container: view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        view.addSubview(headerView)
        
        let headerViewConstraints = Constraints(childView: headerView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.24, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 0)
        ])
        headerViewConstraints.addConstraints()
    }
}
