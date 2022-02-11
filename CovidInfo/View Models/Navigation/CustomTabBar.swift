//
//  CustomTabBar.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 01.02.2022.
//

import UIKit

class CustomTabBar: XIB {

    @IBOutlet var customTabBar: UIView!
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var newsButton: UIButton!
    @IBOutlet var statisticsButton: UIButton!
    @IBOutlet var documentsButton: UIButton!
    @IBOutlet var slider: UIView!
    
    var currentPageIndex: Int = 0
    
    func tabBarPageSliderDirection(tabBarButton: MainPages){
        let tabBarButtonIndex = tabBarIndex(tabBarButton: tabBarButton)
        
        if tabBarButtonIndex < self.currentPageIndex{
            delegates.tabBar.goToPage(pageIndex: tabBarButtonIndex, direction: .reverse)
        } else {
            delegates.tabBar.goToPage(pageIndex: tabBarButtonIndex, direction: .forward)
        }
        self.currentPageIndex = tabBarButtonIndex
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        tabBarButtonSetup(tabBarButton: .home)
        tabBarPageSliderDirection(tabBarButton: .home)
        delegates.navigationBar.setup(page: Page(mainPage: .home, childType: .none))
    }
    
    @IBAction func newsButtonPressed(_ sender: Any) {
        tabBarButtonSetup(tabBarButton: .news)
        tabBarPageSliderDirection(tabBarButton: .news)
        delegates.navigationBar.setup(page: Page(mainPage: .news, childType: .none))
    }
    
    @IBAction func statisticsButtonPressed(_ sender: Any) {
        tabBarButtonSetup(tabBarButton: .statistics)
        tabBarPageSliderDirection(tabBarButton: .statistics)
        delegates.navigationBar.setup(page: Page(mainPage: .statistics, childType: .none))
    }
    
    @IBAction func documentsButtonPressed(_ sender: Any) {
        tabBarButtonSetup(tabBarButton: .documents)
        tabBarPageSliderDirection(tabBarButton: .documents)
        delegates.navigationBar.setup(page: Page(mainPage: .documents, childType: .none))
    }
    
    func tabBarButtonSetup(tabBarButton: MainPages){
        fillTabBarButton(tabBarButton: tabBarButton)
        buttonSliderAnimation(tabBarButton: tabBarButton)
    }
    
    @IBOutlet var sliderLeadingConstraint: NSLayoutConstraint!
    
    func buttonSliderAnimation(tabBarButton: MainPages){
        switch tabBarButton {
        case .home:
            sliderLeadingConstraint.constant = 18
        case .news:
            sliderLeadingConstraint.constant = 113
        case .statistics:
            sliderLeadingConstraint.constant = 204
        case .documents:
            sliderLeadingConstraint.constant = 296
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.slider.layoutIfNeeded()
            self.customTabBar.layoutIfNeeded()
        }, completion: {(finished: Bool) in
        })
    }
    
    func fillTabBarButton(tabBarButton: MainPages){
        switch tabBarButton {
        case .home:
            homeButton.setImage(UIImage(systemName: "house.fill"), for: .normal)
            newsButton.setImage(UIImage(systemName: "newspaper"), for: .normal)
            statisticsButton.setImage(UIImage(systemName: "chart.bar"), for: .normal)
            documentsButton.setImage(UIImage(systemName: "doc.text"), for: .normal)
        case .news:
            homeButton.setImage(UIImage(systemName: "house"), for: .normal)
            newsButton.setImage(UIImage(systemName: "newspaper.fill"), for: .normal)
            statisticsButton.setImage(UIImage(systemName: "chart.bar"), for: .normal)
            documentsButton.setImage(UIImage(systemName: "doc.text"), for: .normal)
        case .statistics:
            homeButton.setImage(UIImage(systemName: "house"), for: .normal)
            newsButton.setImage(UIImage(systemName: "newspaper"), for: .normal)
            statisticsButton.setImage(UIImage(systemName: "chart.bar.fill"), for: .normal)
            documentsButton.setImage(UIImage(systemName: "doc.text"), for: .normal)
        case .documents:
            homeButton.setImage(UIImage(systemName: "house"), for: .normal)
            newsButton.setImage(UIImage(systemName: "newspaper"), for: .normal)
            statisticsButton.setImage(UIImage(systemName: "chart.bar"), for: .normal)
            documentsButton.setImage(UIImage(systemName: "doc.text.fill"), for: .normal)
        }
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
        }
    }
}
