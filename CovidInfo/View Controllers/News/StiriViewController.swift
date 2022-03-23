//
//  StiriViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import UIKit

class StiriViewController: UIViewController {
    
    var page: Page = Page(mainPage: .news, childType: .none)

    override func viewDidLoad() {
        super.viewDidLoad()

        delegates.navigationBar.setup(page: page)
        delegates.news = self
        trustedSources()
    }
    
    func trustedSources(){
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        let scrollViewConstraints = Constraints(childView: scrollView, parentView: self.view, constraints: [
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.12, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0)
        ])
        scrollViewConstraints.addConstraints()
        
        let trustedSources = TrustedSources()
        trustedSources.setup()
        scrollView.addSubview(trustedSources)
        let trustedSourcesConstraints = Constraints(childView: trustedSources, parentView: scrollView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 0),
            Constraint(constraintType: .trailing, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 1, constant: 0)
        ])
        trustedSourcesConstraints.addConstraints()
    }
}

extension StiriViewController: NewsDelegate{}
