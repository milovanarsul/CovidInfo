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
        
        let pageViewControllerDataSource = PageViewControllerDataSource(pages: pages, pageController: .home)
        dataSource = pageViewControllerDataSource
        createViews()
        initialize(pages: pages)
    }
    
    fileprivate func createViews(){
        
        let firstViewController = UIViewController()
        let home = Home()
        delegates.home = self
        firstViewController.view = home
        pages.append(firstViewController)
        
        let secondViewController = UIViewController()
        let triaj = Triaj()
        secondViewController.view = triaj
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
    }
    
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection) {
        goToIndex(pageIndex: pageIndex, direction: direction, pages: pages)
    }
    
    
}
