//
//  HomeViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.03.2022.
//

import Foundation
import UIKit

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
    
    lazy var simptomeAndPreventie: UIView = {
        let label = "Simptome si preventie"
        let content = PreventieAndSimptomeShortcut()
        let view = viewWithLabel(labelText: label, content: content)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 230).isActive = true
        return view
    }()
    
    lazy var triajEpidemiologic: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "triajEpidemiologic")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(triajEpidemiologicTapped)))
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentData = DataManager.currentCountryData
        historicData = DataManager.historicCountryData
        setup()
    }
    
    func setup(){
        view.backgroundColor = .gray
        view.layer.cornerRadius = 24
        
        view.addSubview(scrollView)
        defaultAutoResizingMask(childView: scrollView, parentView: view, width: false)
        
        scrollView.addSubview(contentView)
        defaultAutoResizingMask(childView: contentView, parentView: scrollView, width: true)
        
        contentView.addSubviews(views: [simptomeAndPreventie, triajEpidemiologic])
        
        let simptomeAndPreventieConstraints = Constraints(childView: simptomeAndPreventie, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.25, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 18)
        ])
        simptomeAndPreventieConstraints.addConstraints()
        
        let triajEpidemiologicConstraints = Constraints(childView: triajEpidemiologic, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 8),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -8),
            Constraint(constraintType: .height, multiplier: 1, constant: 110)
        ])
        triajEpidemiologicConstraints.addConstraints()
        triajEpidemiologic.topAnchor.constraint(equalTo: simptomeAndPreventie.bottomAnchor, constant: -10).isActive = true
        
        let quickGraphsLabel = labelWithButton(labelText: "Ultimele Statistici", buttonAction: #selector(statisticsTapped))
        let quickGraphs = UIView()
        self.addSubSwiftUIView(QuickCharts(currentData: currentData!, historicData: historicData!), to: quickGraphs)
        contentView.addSubviews(views: [quickGraphsLabel, quickGraphs])
        
        let quickGraphsLabelConstraints = Constraints(childView: quickGraphsLabel, parentView: contentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 20),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -20)
        ])
        quickGraphsLabelConstraints.addConstraints()
        quickGraphsLabel.topAnchor.constraint(equalTo: triajEpidemiologic.bottomAnchor, constant: -10).isActive = true
        
        let quickGraphsConstraints = Constraints(childView: quickGraphs, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 280)
        ])
        quickGraphsConstraints.addConstraints()
        quickGraphs.topAnchor.constraint(equalTo: quickGraphsLabel.bottomAnchor, constant: 0).isActive = true
    }
    
    func viewWithLabel(labelText: String, content: UIView) -> UIView{
        lazy var label: UILabel = {
            let label = UILabel()
            label.initialize(text: labelText, color: .black, font: boldFont(size: 16), alignment: .left, lines: 1)
            return label
        }()
        
        let view = UIView()
        view.addSubviews(views: [label, content])
        
        let labelConstraints = Constraints(childView: label, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 18),
            Constraint(constraintType: .top, multiplier: 1, constant: 5)
        ])
        labelConstraints.addConstraints()
        
        let contentConstraints = Constraints(childView: content, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 8),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -8),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        contentConstraints.addConstraints()
        content.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5).isActive = true
        
        return view
    }
    
    func labelWithButton(labelText: String, buttonAction: Selector) -> UIStackView {
        lazy var label: UILabel = {
            let label = UILabel()
            label.initialize(text: labelText, color: .black, font: boldFont(size: 16), alignment: .left, lines: 1)
            return label
        }()
        
        lazy var button: UIButton = {
            let button = UIButton()
            button.initialize(title: "Mai mult", titleColor: signatureDarkBlue, cornerRadius: 0, font: boldFont(size: 18), backgroundColor: .clear, image: UIImage(systemName: "arrow.forward"), imagePlacement: NSDirectionalRectEdge.trailing)
            button.addTarget(self, action: buttonAction, for: .touchUpInside)
            return button
        }()
        
        lazy var stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 0)
            stackView.addAranagedSubviews(views: [label, button])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        return stackView
    }
    
    func viewWithLabelButton(labelText: String, content: UIView, buttonAction: Selector) -> UIView{
        lazy var label: UILabel = {
            let label = UILabel()
            label.initialize(text: labelText, color: .black, font: boldFont(size: 16), alignment: .left, lines: 1)
            return label
        }()
        
        lazy var button: UIButton = {
            let button = UIButton()
            button.initialize(title: "Mai mult", titleColor: signatureDarkBlue, cornerRadius: 0, font: boldFont(size: 18), backgroundColor: .clear, image: UIImage(systemName: "arrow.forward"), imagePlacement: NSDirectionalRectEdge.trailing)
            button.addTarget(self, action: buttonAction, for: .touchUpInside)
            return button
        }()
        
        lazy var stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 0)
            stackView.addAranagedSubviews(views: [label, button])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        let view = UIView()
        view.addSubviews(views: [stackView, content])
        
        let stackViewConstraints = Constraints(childView: stackView, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 24),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -24),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 80)
        ])
        stackViewConstraints.addConstraints()
        
        let contentConstraints = Constraints(childView: content, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        contentConstraints.addConstraints()
        content.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5).isActive = true
        
        return stackView
    }
    
    @objc func triajEpidemiologicTapped(){
        delegates.homePage.goToPage(pageIndex: 1, direction: .forward)
        delegates.homePage.updateNavigationBar(page: Page(mainPage: .home, childType: .triaj))
        delegates.main.tabAnimation(visibility: .hide)
    }
    
    @objc func statisticsTapped(){
        delegates.tabBar.goToPage(pageIndex: 3, direction: .forward)
        delegates.homePage.updateNavigationBar(page: Page(mainPage: .statistics, childType: .none))
        delegates.main.tabAnimation(visibility: .show)
    }
}
