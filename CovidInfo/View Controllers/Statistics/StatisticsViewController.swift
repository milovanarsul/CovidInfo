//
//  StatisticsViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 08.04.2022.
//

import Foundation
import UIKit

class StatisticsViewController: UIViewController {
    
    let statisticsData: StatisticsData = parseStatisticsJSON()!
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var topGraphs: UIView = {
        let view = UIView()
        addSubSwiftUIView(TopGraphs(), to: view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup(){
        view.addSubview(scrollView)
        defaultAnchors(childView: scrollView, parentView: view)
        
        scrollView.addSubview(topGraphs)
        
        let topGraphsConstraints = Constraints(childView: topGraphs, parentView: scrollView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 1, constant: 0)
        ])
        topGraphsConstraints.addConstraints()
    }
}
