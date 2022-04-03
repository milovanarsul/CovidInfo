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
        button.clipsToBounds = false
        return button
    }()
    
    lazy var goToTopButton: UIButton = {
        let button = UIButton()
        button.initializeIcon(backgroundImage: UIImage(systemName: "arrow.up.circle"))
        button.isHidden = true
        button.addTarget(self, action: #selector(goToTopButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fillEqually, spacing: 40)
        stackView.isBaselineRelativeArrangement = false
        stackView.addAranagedSubviews(views: [homeButton, newsButton, statisticsButton, accountButton, goToTopButton])
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
    var tabBarBottomConstraint = NSLayoutConstraint()
    var buttonSliderWidth = NSLayoutConstraint()
    
    func setup(){
        delegates.customTabBar = self
        addSubviews(views: [buttonStackView, buttonSlider])
        
        let buttonStackViewConstraints = Constraints(childView: buttonStackView, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 20),
            Constraint(constraintType: .height, multiplier: 1, constant: 30)
        ])
        buttonStackViewConstraints.addConstraints()
        buttonSliderLeadingConstraint = NSLayoutConstraint(item: buttonSlider, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 25)
        tabBarBottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: buttonStackView, attribute: .bottom, multiplier: 1, constant: 10)
        
        buttonSliderWidth = NSLayoutConstraint(item: buttonSlider, attribute: .width, relatedBy: .equal, toItem: homeButton, attribute: .width, multiplier: 0.7, constant: 0)
        NSLayoutConstraint.activate([buttonSliderLeadingConstraint, buttonSliderWidth, NSLayoutConstraint(item: buttonSlider, attribute: .top, relatedBy: .equal, toItem: homeButton, attribute: .bottom, multiplier: 1, constant: 5),NSLayoutConstraint(item: buttonSlider, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 2), tabBarBottomConstraint])
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
    
    @objc func goToTopButtonPressed(_ sender: UIButton) {
        delegates.news.scrollToTop()
    }
    
    func buttonSetup(button: MainPages){
        articlesViewControllerHasBeenPresented ? delegates.main.dismissArticleViewController() : ()
        delegates.main.tabBarScrollAnimation(visibility: .hide, resetsAnimation: true)
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
            buttonSliderLeadingConstraint.constant = 25
        case .news:
            buttonSliderLeadingConstraint.constant = 109
        case .statistics:
            buttonSliderLeadingConstraint.constant = 192
        case .documents:
            buttonSliderLeadingConstraint.constant = 278
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

extension CustomTabBar: CustomTabBarDelegate{
    func increaseBottomConstraint(size: CGFloat) {
        tabBarBottomConstraint.constant = size
        
        if size == 30 {
            buttonSliderLeadingConstraint.constant = 105
        } else {
            buttonSliderLeadingConstraint.constant = 109
        }
    }
    
    func goToTopButtonVisibily(visibily: ViewVisibility){
        switch visibily {
        case .show:
            goToTopButton.isHidden = false
        case .hide:
            goToTopButton.isHidden = true
        }
    }
}
