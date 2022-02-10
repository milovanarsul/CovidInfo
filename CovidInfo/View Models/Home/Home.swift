//
//  Home.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 05.02.2022.
//

import UIKit

class Home: XIB {
    
    @IBAction func button1(_ sender: Any) {
        delegates.homeDelegate.goToPage(pageIndex: 1, direction: .forward)
        delegates.homeDelegate.updateNavigationBar(page: Page(mainPage: .home, childType: .none))
        delegates.mainDelegate.tabBarVisibility(tabBarVisibility: .hide)
    }
    
    @IBAction func button2(_ sender: Any) {
        delegates.homeDelegate.goToPage(pageIndex: 2, direction: .forward)
        delegates.homeDelegate.updateNavigationBar(page: Page(mainPage: .home, childType: .simptome))
        delegates.navigationBarDelegate.buttonSlider(sliderType: .right)
        delegates.mainDelegate.tabBarVisibility(tabBarVisibility: .hide)
    }
    
    @IBAction func button3(_ sender: Any) {
        delegates.homeDelegate.goToPage(pageIndex: 3, direction: .forward)
        delegates.homeDelegate.updateNavigationBar(page: Page(mainPage: .home, childType: .preventie))
        delegates.mainDelegate.tabBarVisibility(tabBarVisibility: .hide)
    }
}
