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
        button.initializeIcon(image: UIImage(systemName: "arrow.up.to.line.circle")!)
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
    
    func setup(){
        delegates.customTabBar = self
        addSubviews(views: [buttonStackView, buttonSlider])
        
        let buttonStackViewConstraints = Constraints(childView: buttonStackView, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.8, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 30),
            Constraint(constraintType: .top, multiplier: 1, constant: 10)
        ])
        buttonStackViewConstraints.addConstraints()
        
        buttonSliderLeadingConstraint = buttonSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 41)
        NSLayoutConstraint.activate([
            buttonSliderLeadingConstraint,
            buttonSlider.widthAnchor.constraint(equalTo: homeButton.widthAnchor, multiplier: 0.7),
            buttonSlider.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 5),
            buttonSlider.heightAnchor.constraint(equalToConstant: 2)
        ])
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
        switch delegates.tabBar.getCurrentIndex(){
        case 0:
            delegates.home.scrollToTop()
        case 1:
            let currentInfoIndex = delegates.info.getCategoriesCurrentIndex()
            switch currentInfoIndex{
            case 0:
                delegates.countryController.scrollToTop()
            case 1:
                delegates.infoCardsCollectionView.scrollToTop()
            case 2:
                delegates.infoCardsCollectionView.scrollToTop()
            case 3:
                delegates.news.scrollToTop()
            default:
                ()
            }
        case 2:
            delegates.news.scrollToTop()
        case 3:
            delegates.statistics.scrollToTop()
        default:
            ()
        }
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
            buttonSliderLeadingConstraint.constant = 41
        case .info:
            buttonSliderLeadingConstraint.constant = 121
        case .news:
            buttonSliderLeadingConstraint.constant = 202
        case .statistics:
            buttonSliderLeadingConstraint.constant = 283
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
            offset = 5
        case 1:
            offset = 0
        case 2:
            offset = -6
        case 3: ()
            offset = -13
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
            buttonSliderAnimation(tabBarButton: tabBarButton(index: delegates.tabBar.getCurrentIndex()))
            shouldIncreaseLeadingAnchor = true
        case .hide:
            ()
            currentButtonSliderAnimation()
        }
    }
}
