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
    
    lazy var statisticsLabel: UIStackView = {
        let label = UILabel()
        label.initialize(text: "Statistici", color: .black, font: boldFont(size: 20), alignment: .left, lines: 1)
        
        let button = UIButton()
        button.initialize(title: "Mai mult", titleColor: signatureDarkBlue, cornerRadius: 0, font: boldFont(size: 18), backgroundColor: .clear, image: UIImage(systemName: "arrow.forward"), imagePlacement: NSDirectionalRectEdge.trailing)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let stackView = UIStackView()
        stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 0)
        stackView.addAranagedSubviews(views: [label, button])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    @objc func buttonAction(_ sender: UIButton){
        delegates.tabBar.goToPage(pageIndex: 3, direction: .forward)
        delegates.customTabBar.goToPage(index: 3)
    }
    
    lazy var quickGraphs: UIView = {
        let view = UIView()
        self.addSubSwiftUIView(QuickCharts(currentData: currentData!, historicData: historicData!), to: view)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 180).isActive = true
        return view
    }()
    
    lazy var viewShortcuts: UIStackView = {
        let stackView = HomePreventieandSimptomeShortcut()
        stackView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        return stackView
    }()
    
    lazy var cardView: UIView = {
        let view = CountryCardView(data: currentData!)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 400).isActive = true
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
        
        contentView.addSubviews(views: [headerView, statisticsLabel, quickGraphs, viewShortcuts])
        
        let headerViewConstraints = Constraints(childView: headerView, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.24, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 18)
        ])
        headerViewConstraints.addConstraints()
        
        let statisticsLabelConstraints = Constraints(childView: statisticsLabel, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .height, multiplier: 1, constant: 80)
        ])
        statisticsLabelConstraints.addConstraints()
        statisticsLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10).isActive = true
        
        let quickGraphsConstraints = Constraints(childView: quickGraphs, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12)
        ])
        quickGraphsConstraints.addConstraints()
        quickGraphs.topAnchor.constraint(equalTo: statisticsLabel.bottomAnchor, constant: 5).isActive = true
        
        let viewShorcutsConstraints = Constraints(childView: viewShortcuts, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12)
        ])
        viewShorcutsConstraints.addConstraints()
        viewShortcuts.topAnchor.constraint(equalTo: quickGraphs.bottomAnchor, constant: 40).isActive = true
    }
}
