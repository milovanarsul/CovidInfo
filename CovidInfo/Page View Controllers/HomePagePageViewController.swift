//
//  HomePagePageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.02.2022.
//

import UIKit

class HomePageViewController: UIPageViewController {
    
    fileprivate var pages: [UIViewController] = []
    
    var page: Page = Page(mainPage: .home, childType: .none)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.navigationBar.setup(page: page)
        
        let pageViewControllerDataSource = PageViewControllerDataSource(pages: pages)
        dataSource = pageViewControllerDataSource
        createViews()
        initialize(pages: pages, scroll: false)
    }
    
    fileprivate func createViews(){
        
        let firstViewController = HomeViewController()
        delegates.homePage = self
        pages.append(firstViewController)
        
        let secondViewController = TriajPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pages.append(secondViewController)
    
        let thirdViewController = SimptomeAndPreventieViewController(staticType: .preventie)
        pages.append(thirdViewController)
        
        let fourthViewController = SimptomeAndPreventieViewController(staticType: .simptome)
        pages.append(fourthViewController)
    }
}

extension HomePageViewController: HomePageDelegate{
    func updateNavigationBar(page: Page) {
        delegates.navigationBar.setup(page: page)
        delegates.navigationBar.buttonSlider(sliderType: .right)
        delegates.main.tabBarVisibility(tabBarVisibility: .hide)
    }
    
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection) {
        goToIndex(pageIndex: pageIndex, direction: direction, pages: pages)
    }
}
