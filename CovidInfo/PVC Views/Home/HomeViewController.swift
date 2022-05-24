//
//  HomeViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.03.2022.
//

import Foundation
import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    @Published var currentData: CurrentData?
    @Published var historicData: HistoricData?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.cornerRadius = 24
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        CovidInfo.embed.headerPageViewController(parent: self, container: view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 190).isActive = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = loadData()
        currentData = data.0
        historicData = data.1
        
        setup()
    }
    
    func setup(){
        view.backgroundColor = UIColor("#f2f2f7")
        view.layer.cornerRadius = 24
        
        view.addSubview(scrollView)
        defaultAutoResizingMask(childView: scrollView, parentView: view, width: false)
        
        scrollView.addSubview(contentView)
        defaultAutoResizingMask(childView: contentView, parentView: scrollView, width: true)
        
        contentView.addSubviews(views: [headerView])
        
        let headerViewConstraints = Constraints(childView: headerView, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.24, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 18)
        ])
        headerViewConstraints.addConstraints()
    }
}
