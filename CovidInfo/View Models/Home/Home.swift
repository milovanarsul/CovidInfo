//
//  Home.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 05.02.2022.
//

import UIKit

class Home: XIB {
    
    @IBAction func button1(_ sender: Any) {
        delegates.home.goToPage(pageIndex: 1, direction: .forward)
        delegates.home.updateNavigationBar(page: Page(mainPage: .home, childType: .none))
        delegates.main.tabBarVisibility(tabBarVisibility: .hide)
    }
    
    @IBAction func button2(_ sender: Any) {
        delegates.home.goToPage(pageIndex: 2, direction: .forward)
        delegates.home.updateNavigationBar(page: Page(mainPage: .home, childType: .simptome))
        delegates.navigationBar.buttonSlider(sliderType: .right)
        delegates.main.tabBarVisibility(tabBarVisibility: .hide)
    }
    
    @IBAction func button3(_ sender: Any) {
        delegates.home.goToPage(pageIndex: 3, direction: .forward)
        delegates.home.updateNavigationBar(page: Page(mainPage: .home, childType: .preventie))
        delegates.main.tabBarVisibility(tabBarVisibility: .hide)
    }
}
