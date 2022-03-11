//
//  MainPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    fileprivate var pages: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageViewControllerDataSource = PageViewControllerDataSource(pages: pages)
        dataSource = pageViewControllerDataSource
        createViewControllers()
        initialize(pages: pages, scroll: false)
    }
    
    fileprivate func createViewControllers(){
        
        let homeViewController = HomePageViewController(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
        delegates.homePage = homeViewController
        pages.append(homeViewController)
        
        let newsViewController = StiriViewController()
        pages.append(newsViewController)
        
        let statisticsViewController = StatisticiViewController()
        pages.append(statisticsViewController)
        
        let documentsViewController = DocumenteViewController()
        pages.append(documentsViewController)
    }
}

extension MainPageViewController: TabBarDelegate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection) {
        goToIndex(pageIndex: pageIndex, direction: direction, pages: pages)
    }
}
