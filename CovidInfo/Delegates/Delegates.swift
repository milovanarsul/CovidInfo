//
//  Delegates.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.02.2022.
//

import Foundation
import UIKit

class Delegates{
    var onboarding: OnboardingDelegate! = nil
    var onboardingSubDelegate: OnboardingSubDelegate! = nil
    var main: MainDelegate! = nil
    var navigationBar: NavigationBarDelegate! = nil
    var tabBar: TabBarDelegate! = nil
    var home: HomePageDelegate! = nil
    var staticInfo: StaticDelegate! = nil
    
    init(){}
}

let delegates: Delegates = Delegates()

protocol OnboardingDelegate{
    func goToPage()
    func modal()
    func dismissModal()
    func playAnimation()
}

protocol OnboardingSubDelegate{
    func finishOnboarding()
}

protocol MainDelegate{
    func tabBarVisibility(tabBarVisibility: TabBarVisibility)
}

protocol NavigationBarDelegate{
    func setup(page: Page)
    func buttonSlider(sliderType: currentPageButtonSlider)
}

protocol TabBarDelegate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection)
}

protocol HomePageDelegate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection)
    func updateNavigationBar(page: Page)
}

protocol StaticDelegate{
    func getCards() -> ([SimptomeAndPreventieData], UIColor, Int)
}
