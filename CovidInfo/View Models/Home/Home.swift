//
//  Home.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 05.02.2022.
//

import UIKit

class Home: XIB {
    
    var homePageDelegate: HomePageDelegate!
    var navigationBarDelegate: NavigationBarDelegate!
    
    @IBAction func button1(_ sender: Any) {
        homePageDelegate.goToPage(pageIndex: 1, direction: .forward)
        homePageDelegate.updateNavigationBar(page: Page(mainPage: .home, childType: .none))
    }
    
    
    @IBAction func button2(_ sender: Any) {
        homePageDelegate.goToPage(pageIndex: 2, direction: .forward)
        homePageDelegate.updateNavigationBar(page: Page(mainPage: .home, childType: .simptome))
        navigationBarDelegate.buttonSlider(sliderType: .right)
    }
    
    
    @IBAction func button3(_ sender: Any) {
        homePageDelegate.goToPage(pageIndex: 3, direction: .forward)
        homePageDelegate.updateNavigationBar(page: Page(mainPage: .home, childType: .preventie))
    }
}
