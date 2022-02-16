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
    var onboardingSub: OnboardingSubDelegate! = nil
    var main: MainDelegate! = nil
    var navigationBar: NavigationBarDelegate! = nil
    var tabBar: TabBarDelegate! = nil
    var home: HomePageDelegate! = nil
    var staticInfo: StaticDelegate! = nil
    var triaj: TriajDelegate! = nil
    var triajSub: TriajSubDelegate! = nil
    
    init(){}
}

let delegates: Delegates = Delegates()

@objc protocol OnboardingDelegate{
    @objc optional func nextPage()
    @objc optional func modal()
    @objc optional func dismissModal()
    @objc optional func getCurrentIndex() -> Int
}

protocol OnboardingSubDelegate{
    func finishOnboarding()
    func setPageControl()
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

protocol TriajDelegate{
    func nextPage(index: Int)
    func currentIndex() -> Int
    func goToStart()
    func endTriaj()
}

protocol TriajSubDelegate{
    func resizeContainerView()
    func resetContainerView()
}
