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
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.initializeIcon(image: UIImage(systemName: "doc.text.image"))
        button.addTarget(self, action: #selector(infoButtonPressed(_:)), for: .touchUpInside)
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
        stackView.addAranagedSubviews(views: [homeButton, infoButton, newsButton ,statisticsButton, goToTopButton])
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
    var tabBarTopConstraint = NSLayoutConstraint()
    var buttonSliderWidth = NSLayoutConstraint()
    var buttonSliderTopConstraint = NSLayoutConstraint()
    
    func setup(){
        delegates.customTabBar = self
        addSubviews(views: [buttonStackView, buttonSlider])
        
        let buttonStackViewConstraints = Constraints(childView: buttonStackView, parentView: self, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 20),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -20),
            Constraint(constraintType: .height, multiplier: 1, constant: 30)
        ])
        buttonStackViewConstraints.addConstraints()
        tabBarTopConstraint = buttonStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        tabBarTopConstraint.isActive = true
        
        buttonSliderLeadingConstraint = NSLayoutConstraint(item: buttonSlider, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 25)
        tabBarBottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: buttonStackView, attribute: .bottom, multiplier: 1, constant: 10)
        
        buttonSliderWidth = NSLayoutConstraint(item: buttonSlider, attribute: .width, relatedBy: .equal, toItem: homeButton, attribute: .width, multiplier: 0.7, constant: 0)
        buttonSliderTopConstraint = NSLayoutConstraint(item: buttonSlider, attribute: .top, relatedBy: .equal, toItem: homeButton, attribute: .bottom, multiplier: 1, constant: 5)
        NSLayoutConstraint.activate([buttonSliderLeadingConstraint, buttonSliderWidth, buttonSliderTopConstraint,NSLayoutConstraint(item: buttonSlider, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 2), tabBarBottomConstraint])
    }
    
    @objc func homeButtonPressed(_ sender: UIButton) {
        buttonSetup(button: .home)
    }
    
    @objc func infoButtonPressed(_ sender: UIButton) {
        buttonSetup(button: .info)
    }
    
    @objc func newsButtonPressed(_ sender: UIButton) {
        buttonSetup(button: .news)
    }
    
    @objc func statisticsButtonPressed(_ sender: UIButton) {
        buttonSetup(button: .statistics)
    }
    
    @objc func goToTopButtonPressed(_ sender: UIButton) {
        delegates.news.scrollToTop()
    }
    
    func buttonSetup(button: MainPages){
        delegates.main.animateContentView(size: 5)
        delegates.main.tabBarScrollAnimation(visibility: .show)
        tabBarButtonSetup(tabBarButton: button)
        tabBarPageSliderDirection(tabBarButton: button)
        delegates.navigationBar.setup(page: Page(mainPage: button, childType: .none))
        DataManager.reloadViews()
    }
    
    func tabBarButtonSetup(tabBarButton: MainPages){
        buttons = [homeButton, infoButton, newsButton, statisticsButton]
        fillTabBarButton(tabBarButton: tabBarButton)
        buttonSliderAnimation(tabBarButton: tabBarButton)
        delegates.navigationBar.simulateLocationButtonTap(viewVisibility: .hide)
        
        switch tabBarButton{
        case .home:
            delegates.main.certifficateButtonAnimation(visibility: .show)
            delegates.main.planTripButtonAnimation(visibility: .hide)
            delegates.main.statisticsActionsAnimation(visibility: .hide)
            delegates.navigationBar.locationButtonAnimation(visibility: .hide)
            delegates.navigationBar.certifficateButtonAnimation(visibility: .hide)
            delegates.main.tabBarExtensionAnimation(visibility: .hide)
        case .info:
            delegates.main.planTripButtonAnimation(visibility: .show)
            delegates.main.certifficateButtonAnimation(visibility: .hide)
            delegates.main.statisticsActionsAnimation(visibility: .hide)
            delegates.navigationBar.locationButtonAnimation(visibility: .show)
            delegates.navigationBar.certifficateButtonAnimation(visibility: .show)
            delegates.main.tabBarExtensionAnimation(visibility: .hide)
        case .statistics:
            delegates.navigationBar.locationButtonAnimation(visibility: .show)
            delegates.navigationBar.certifficateButtonAnimation(visibility: .show)
            delegates.main.certifficateButtonAnimation(visibility: .hide)
            delegates.main.planTripButtonAnimation(visibility: .hide)
            delegates.main.statisticsActionsAnimation(visibility: .show)
            delegates.main.tabBarExtensionAnimation(visibility: .hide)
        default:
            delegates.main.planTripButtonAnimation(visibility: .hide)
            delegates.main.certifficateButtonAnimation(visibility: .hide)
            delegates.main.statisticsActionsAnimation(visibility: .hide)
            delegates.navigationBar.locationButtonAnimation(visibility: .hide)
            delegates.navigationBar.certifficateButtonAnimation(visibility: .show)
            delegates.main.tabBarExtensionAnimation(visibility: .show)
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
        case .info:
            buttonSliderLeadingConstraint.constant = 115
        case .news:
            buttonSliderLeadingConstraint.constant = 202
        case .statistics:
            buttonSliderLeadingConstraint.constant = 290
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.buttonSlider.layoutIfNeeded()
            self.layoutIfNeeded()
        })
    }
    
    func fillTabBarButton(tabBarButton: MainPages){
        let buttonIndex = tabBarIndex(tabBarButton: tabBarButton)
        let images = [home, info, news, statistics]
        
        for index in 0..<buttons.count{
            buttons[index].setImage(UIImage(systemName: images[index]), for: .normal)
        }
        
        buttons[buttonIndex].setImage(UIImage(systemName: images[buttonIndex] + ".fill"), for: .normal)
    }
    
    func tabBarIndex(tabBarButton: MainPages) -> Int{
        switch tabBarButton {
        case .home:
            return 0
        case .info:
            return 1
        case .news:
            return 2
        case .statistics:
            return 3
        }
    }
    
    func tabBarButton(index: Int) -> MainPages{
        switch index{
        case 0:
            return .home
        case 1:
            return .info
        case 2:
            return .news
        case 3:
            return .statistics
        default:
            ()
        }
        
        return .home
    }
    
    var shouldIncreaseLeadingAnchor: Bool = true
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
    
    func currentButtonSliderAnimation(){
        let currentIndex = delegates.tabBar.getCurrentIndex()
        var offset: CGFloat?
        
        switch currentIndex {
        case 0:
            offset = 4
        case 1:
            offset = 18
        case 2:
            offset = 35
        case 3: ()
            offset = 48
        default: ()
        }
        
        if shouldIncreaseLeadingAnchor{
            let currentLeadingAnchor = buttonSliderLeadingConstraint.constant
            buttonSliderLeadingConstraint.constant = currentLeadingAnchor + offset!
            shouldIncreaseLeadingAnchor = false
        }
    }
    
    func goToPage(index: Int){
        buttonSetup(button: tabBarButton(index: index))
    }
    
    func tabBarScroll(visibility: ViewVisibility){
        switch visibility {
        case .show:
            tabBarTopConstraint.constant = 10
            buttonSliderTopConstraint.constant = 5
            buttonSliderAnimation(tabBarButton: tabBarButton(index: delegates.tabBar.getCurrentIndex()))
            shouldIncreaseLeadingAnchor = true
        case .hide:
            tabBarTopConstraint.constant = -10
            buttonSliderTopConstraint.constant = -17
            currentButtonSliderAnimation()
        }
    }
}
