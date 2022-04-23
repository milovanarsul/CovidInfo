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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.cornerRadius = 24
        return scrollView
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        CovidInfo.embed.headerPageViewController(parent: self, container: view)
        return view
    }()
    
    lazy var quickGraphs: UIView = {
        let view = UIView()
        let quickGraphs = QuickGraphs().environment(\.managedObjectContext, context)
        addSubSwiftUIView(quickGraphs, to: view)
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var viewShortcuts: UIStackView = {
        let stackView = UIStackView()
        stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 10)
        stackView.addArrangedSubview(horizontalViewShortcut(text: "Simptome", image: "SimptomeHomeShortcut", action: #selector(simptomeShortcutAction)))
        stackView.addArrangedSubview(horizontalViewShortcut(text: "Preventie ", image: "PreventieHomeShortcut", action: #selector(preventieShortcutAction)))
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        view.backgroundColor = UIColor("#f2f2f7")
        view.layer.cornerRadius = 24
        
        view.addSubview(scrollView)
        let scrollViewConstraints = Constraints(childView: scrollView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        scrollViewConstraints.addConstraints()
        
        scrollView.addSubview(headerView)
        
        let headerViewConstraints = Constraints(childView: headerView, parentView: scrollView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.95, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.24, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 18)
        ])
        headerViewConstraints.addConstraints()
        
        scrollView.addSubview(quickGraphs)
        let quickGraphsConstraints = Constraints(childView: quickGraphs, parentView: scrollView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.9, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.35, constant: 0)
        ])
        quickGraphsConstraints.addConstraints()
        NSLayoutConstraint.activate([quickGraphs.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8)])
        
        scrollView.addSubview(viewShortcuts)
        let viewShortcutsConstraints = Constraints(childView: viewShortcuts, parentView: scrollView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.95, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.17, constant: 0)
        ])
        viewShortcutsConstraints.addConstraints()
        NSLayoutConstraint.activate([viewShortcuts.topAnchor.constraint(equalTo: quickGraphs.bottomAnchor, constant: 10)])
    }
    
    func horizontalViewShortcut(text: String, image: String, action: Selector) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: image)
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        defaultConstraints(childView: backgroundImage, parentView: view)
        
        let label = UILabel()
        label.initialize(text: text, color: .black, font: boldFont(size: 26), alignment: .left, lines: 1)
        view.addSubview(label)
        let labelConstraints = Constraints(childView: label, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 20),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0)
        ])
        labelConstraints.addConstraints()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: action))
        
        return view
    }
    
    @objc func simptomeShortcutAction(){
        delegates.homePage.goToPage(pageIndex: 2, direction: .forward)
        delegates.homePage.updateNavigationBar(page: Page(mainPage: .home, childType: .simptome))
        delegates.main.tabAnimation(visibility: .hide)
    }
    
    @objc func preventieShortcutAction(){
        delegates.homePage.goToPage(pageIndex: 3, direction: .forward)
        delegates.homePage.updateNavigationBar(page: Page(mainPage: .home, childType: .preventie))
        delegates.main.tabAnimation(visibility: .hide)
    }
}
