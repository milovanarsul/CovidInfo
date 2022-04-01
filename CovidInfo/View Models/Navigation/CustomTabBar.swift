//
//  CustomTabBar.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 01.02.2022.
//

import UIKit

class CustomTabBar: UIView {
    
    lazy var homeButton: UIButton = {
        let button = UIButton()
        button.initializeIcon(image: UIImage(systemName: "house.fill")!)
        button.addTarget(self, action: #selector(homeButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var newsButton: UIButton = {
        let button = UIButton()
        button.initializeIcon(image: UIImage(systemName: "newspaper")!)
        button.addTarget(self, action: #selector(newsButtonPressed(_:)), for: .touchUpInside)

        return button
    }()
    
    lazy var statisticsButton: UIButton = {
        let button = UIButton()
        button.initializeIcon(image: UIImage(systemName: "chart.bar")!)
        button.addTarget(self, action: #selector(statisticsButtonPressed(_:)), for: .touchUpInside)

        return button
    }()
    
    lazy var accountButton: UIButton = {
        let button = UIButton()
        button.initializeIcon(backgroundImage: UIImage(named: "Profile Picture"))
        button.addTarget(self, action: #selector(accountButtonPressed(_:)), for: .touchUpInside)

        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fillEqually, spacing: 40)
        stackView.isBaselineRelativeArrangement = false
        stackView.addAranagedSubviews(views: [homeButton, newsButton, statisticsButton, accountButton])
        return stackView
    }()
    
    lazy var buttonSlider: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var buttons: [UIButton]!
    var currentPageIndex: Int? = 0
    var buttonSliderLeadingConstraint = NSLayoutConstraint()
    
    func setup(){
        addSubviews(views: [buttonStackView, buttonSlider])
        
        let buttonStackViewConstraints = Constraints(childView: buttonStackView, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 20),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 0)
        ])
        buttonStackViewConstraints.addConstraints()
        
        buttonSliderLeadingConstraint = NSLayoutConstraint(item: buttonSlider, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 20)
        NSLayoutConstraint.activate([buttonSliderLeadingConstraint, NSLayoutConstraint(item: buttonSlider, attribute: .width, relatedBy: .equal, toItem: homeButton, attribute: .width, multiplier: 1, constant: 0.673077), NSLayoutConstraint(item: buttonSlider, attribute: .top, relatedBy: .equal, toItem: homeButton, attribute: .bottom, multiplier: 1, constant: -5),NSLayoutConstraint(item: buttonSlider, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 2)])
    }
    
    @objc func homeButtonPressed(_ sender: UIButton) {
        buttonSetup(button: .home)
    }
    
    @objc func newsButtonPressed(_ sender: UIButton) {
        buttonSetup(button: .news)
        delegates.main.presentArticleViewController()
    }
    
    @objc func statisticsButtonPressed(_ sender: UIButton) {
        buttonSetup(button: .statistics)
    }
    
    @objc func accountButtonPressed(_ sender: UIButton) {
        delegates.main.accountModal()
    }
    
    func buttonSetup(button: MainPages){
        articlesViewControllerHasBeenPresented ? delegates.main.dismissArticleViewController() : ()
        tabBarButtonSetup(tabBarButton: button)
        tabBarPageSliderDirection(tabBarButton: button)
        delegates.navigationBar.setup(page: Page(mainPage: button, childType: .none))
    }
    
    func tabBarButtonSetup(tabBarButton: MainPages){
        buttons = [homeButton, newsButton, statisticsButton]
        fillTabBarButton(tabBarButton: tabBarButton)
        buttonSliderAnimation(tabBarButton: tabBarButton)
        
        if tabBarButton != .home{
            articlesViewControllerHasBeenPresented ? () : delegates.main.certifficateButtonAnimation(visibility: .hide)
            delegates.navigationBar.certifficateButtonAnimation(visibility: .show)
        } else {
            delegates.main.certifficateButtonAnimation(visibility: .show)
            delegates.navigationBar.certifficateButtonAnimation(visibility: .hide)
        }
    }
    
    func tabBarPageSliderDirection(tabBarButton: MainPages){
        let tabBarButtonIndex = tabBarIndex(tabBarButton: tabBarButton)
        
        if tabBarButtonIndex < self.currentPageIndex!{
            delegates.tabBar.goToPage(pageIndex: tabBarButtonIndex, direction: .reverse)
        } else {
            delegates.tabBar.goToPage(pageIndex: tabBarButtonIndex, direction: .forward)
        }
        self.currentPageIndex = tabBarButtonIndex
    }
    
    func buttonSliderAnimation(tabBarButton: MainPages){
        switch tabBarButton {
        case .home:
            buttonSliderLeadingConstraint.constant = 20
        case .news:
            buttonSliderLeadingConstraint.constant = 106
        case .statistics:
            buttonSliderLeadingConstraint.constant = 187
        case .documents:
            buttonSliderLeadingConstraint.constant = 273
        default:
            ()
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.buttonSlider.layoutIfNeeded()
            self.layoutIfNeeded()
        })
    }
    
    func fillTabBarButton(tabBarButton: MainPages){
        let buttonIndex = tabBarIndex(tabBarButton: tabBarButton)
        let images = [home, news, statistics]
        
        for index in 0..<buttons.count{
            buttons[index].setImage(UIImage(systemName: images[index]), for: .normal)
        }
        
        buttons[buttonIndex].setImage(UIImage(systemName: images[buttonIndex] + ".fill"), for: .normal)
    }
    
    func tabBarIndex(tabBarButton: MainPages) -> Int{
        switch tabBarButton {
        case .home:
            return 0
        case .news:
            return 1
        case .statistics:
            return 2
        case .documents:
            return 3
        default:
            return -1
        }
    }
}
