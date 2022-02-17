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
    
    func buttonSetup(button: MainPages){
        tabBarButtonSetup(tabBarButton: button)
        tabBarPageSliderDirection(tabBarButton: button)
        delegates.navigationBar.setup(page: Page(mainPage: button, childType: .none))
        
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        buttonSetup(button: .home)
    }
    
    @IBAction func newsButtonPressed(_ sender: Any) {
        buttonSetup(button: .news)
    }
    
    @IBAction func statisticsButtonPressed(_ sender: Any) {
        buttonSetup(button: .statistics)
    }
    
    @IBAction func documentsButtonPressed(_ sender: Any) {
        buttonSetup(button: .documents)
    }
    
    func tabBarButtonSetup(tabBarButton: MainPages){
        fillTabBarButton(tabBarButton: tabBarButton)
        buttonSliderAnimation(tabBarButton: tabBarButton)
    }
    
    @IBOutlet var sliderLeadingConstraint: NSLayoutConstraint!
    
    func buttonSliderAnimation(tabBarButton: MainPages){
        switch tabBarButton {
        case .home:
            sliderLeadingConstraint.constant = 27
        case .news:
            sliderLeadingConstraint.constant = 113
        case .statistics:
            sliderLeadingConstraint.constant = 198
        case .documents:
            sliderLeadingConstraint.constant = 283
        default:
            ()
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.slider.layoutIfNeeded()
            self.customTabBar.layoutIfNeeded()
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
        default:
            ()
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
        default:
            return -1
        }
    }
}
