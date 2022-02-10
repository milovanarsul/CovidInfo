//
//  Delegates.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.02.2022.
//

import Foundation
import UIKit

class Delegates{
    var onboardingPageViewControllerDelegate: OnboardingPageViewControllerDelegate! = nil
    var onboardingViewControllerDelegate: OnboardingViewControllerDelegate! = nil
    var navigationBarDelegate: NavigationBarDelegate! = nil
    var tabBarDelegate: TabBarDelegate! = nil
    var homeDelegate: HomePageDelegate! = nil
    var mainDelegate: MainDelegate! = nil
    var staticDelegate: StaticDelegate! = nil
    
    init(){}
}

let delegates: Delegates = Delegates()

protocol OnboardingPageViewControllerDelegate{
    func nextButtonIsTapped()
}

protocol OnboardingViewControllerDelegate{
    func showEnrollCertificateButton(show: Bool)
    func showCreateAccountButton(show: Bool)
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

protocol MainDelegate{
    func tabBarVisibility(tabBarVisibility: TabBarVisibility)
}

protocol StaticDelegate{
    func getCards() -> ([SimptomeAndPreventieData], UIColor, Int)
}
